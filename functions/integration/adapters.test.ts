// Integration tests: the real Firebase adapters from functions/src against the
// Firestore + Auth emulators (run through `npm test`).
import { randomBytes } from 'node:crypto';
import { initializeApp } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { getFirestore } from 'firebase-admin/firestore';
import { beforeAll, beforeEach, describe, expect, it } from 'vitest';
import { Deps, completeSignup, lookupLoginEmail, requestOtp, resetPassword } from '../src/authService';
import { FirebaseAccountData } from '../src/accountData';
import { deleteAccount } from '../src/accountService';
import { FirebaseDirectory } from '../src/directory';
import { FirestoreStore } from '../src/firestoreStores';
import { OtpProvider, issueChallenge, verifyChallenge } from '../src/otp';
import { Challenge, Counter } from '../src/types';
import { AppError } from '../src/validation';

initializeApp({ projectId: 'demo-falih' });
const db = getFirestore();
const auth = getAuth();
const dir = new FirebaseDirectory(auth, db);
const profile = (userName: string) => ({ fullName: 'Ali', userName, schoolName: 'S', grade: '12' });

async function signInWithPassword(email: string, password: string): Promise<boolean> {
  const host = process.env.FIREBASE_AUTH_EMULATOR_HOST!;
  const r = await fetch(`http://${host}/identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=fake`, {
    method: 'POST', headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password, returnSecureToken: true }),
  });
  return r.ok;
}

async function clearAll() {
  const host = process.env.FIREBASE_AUTH_EMULATOR_HOST!;
  await fetch(`http://${host}/emulator/v1/projects/demo-falih/accounts`, { method: 'DELETE' });
  const fs = process.env.FIRESTORE_EMULATOR_HOST!;
  await fetch(`http://${fs}/emulator/v1/projects/demo-falih/databases/(default)/documents`, { method: 'DELETE' });
}

beforeAll(() => {
  expect(process.env.FIRESTORE_EMULATOR_HOST).toBeTruthy();
  expect(process.env.FIREBASE_AUTH_EMULATOR_HOST).toBeTruthy();
});
beforeEach(clearAll);

/** Provider that always confirms: isolates our own single-use guarantee from the provider's. */
const yes: OtpProvider = { send: async () => {}, check: async () => true };

describe('FirestoreStore (real transactions)', () => {
  it('lets exactly one of 20 concurrent correct verifications succeed', async () => {
    const store = new FirestoreStore<Challenge>(db, 'otp_challenges');
    await issueChallenge(store, { id: 'c1', phone: '771234567', purpose: 'signup', now: Date.now() });
    const results = await Promise.all(
      Array.from({ length: 20 }, () => verifyChallenge(store, yes, { id: 'c1', code: '482913', purpose: 'signup', now: Date.now() })),
    );
    expect(results.filter((r) => r.status === 'ok')).toHaveLength(1);
    expect(results.filter((r) => r.status === 'consumed')).toHaveLength(19);
  });

  it('stores no code material', async () => {
    const store = new FirestoreStore<Challenge>(db, 'otp_challenges');
    await issueChallenge(store, { id: 'c2', phone: '771234567', purpose: 'signup', now: Date.now() });
    const data = (await db.collection('otp_challenges').doc('c2').get()).data()!;
    expect(Object.keys(data).sort()).toEqual(['attempts', 'consumed', 'createdAt', 'expiresAt', 'phone', 'purpose']);
  });
});

describe('FirebaseDirectory', () => {
  it('creates the auth user, profile document and username claim', async () => {
    const acct = await dir.createAccount({ phone: '771234567', password: 'secret1', profile: profile('Ali_1') });
    expect(acct.email).toBe('771234567@users.falih.invalid');
    expect((await auth.getUser(acct.uid)).email).toBe(acct.email);
    const doc = (await db.collection('users').doc(acct.uid).get()).data()!;
    expect(doc).toMatchObject({ FullName: 'Ali', UserName: 'Ali_1', Phone: '771234567', fakeEmail: acct.email, IsVerified: 'true', 'School Name': 'S', Grade: '12' });
    expect((await db.collection('usernames').doc('ali_1').get()).get('phone')).toBe('771234567');
    expect(await signInWithPassword(acct.email, 'secret1')).toBe(true);
  });

  it('rejects a duplicate username case-insensitively and creates no second user', async () => {
    await dir.createAccount({ phone: '771234567', password: 'secret1', profile: profile('Ali_1') });
    await expect(dir.createAccount({ phone: '700000000', password: 'secret1', profile: profile('ALI_1') })).rejects.toMatchObject({ message: 'username-taken' });
    expect(await dir.phoneExists('700000000')).toBe(false);
  });

  it('rejects a duplicate phone and releases the username it had claimed', async () => {
    await dir.createAccount({ phone: '771234567', password: 'secret1', profile: profile('first') });
    await expect(dir.createAccount({ phone: '771234567', password: 'secret1', profile: profile('second') })).rejects.toBeInstanceOf(AppError);
    expect((await db.collection('usernames').doc('second').get()).exists).toBe(false);
  });

  it('finds legacy gmail accounts and legacy usernames that have no claim document', async () => {
    const legacy = await auth.createUser({ email: '771111111@gmail.com', password: 'oldpass1' });
    await db.collection('users').doc(legacy.uid).set({ UserName: 'OldUser', Phone: '771111111' });
    expect((await dir.findAccountByPhone('771111111'))?.email).toBe('771111111@gmail.com');
    expect(await dir.usernameToPhone('OldUser')).toBe('771111111');
    expect(await dir.phoneExists('771111111')).toBe(true);
    expect(await dir.usernameToPhone('nobody')).toBeNull();
  });

  it('setPassword changes the password', async () => {
    const acct = await dir.createAccount({ phone: '771234567', password: 'secret1', profile: profile('ali') });
    await dir.setPassword(acct.uid, 'newpass1');
    expect(await signInWithPassword(acct.email, 'secret1')).toBe(false);
    expect(await signInWithPassword(acct.email, 'newpass1')).toBe(true);
  });
});

describe('end to end with real stores', () => {
  const sent: { phone: string; code: string }[] = [];
  const pending = new Map<string, string>();
  const provider: OtpProvider = {
    send: async (phone) => { const code = String(100000 + sent.length); pending.set(phone, code); sent.push({ phone, code }); },
    check: async (phone, c) => { const ok = pending.get(phone) === c; if (ok) pending.delete(phone); return ok; },
  };
  const deps = (): Deps => ({
    challenges: new FirestoreStore<Challenge>(db, 'otp_challenges'),
    limits: new FirestoreStore<Counter>(db, 'rate_limits'),
    users: dir,
    otp: provider,
    pepper: 'pepper', decoySecret: 'decoy', now: () => Date.now(),
    newId: () => randomBytes(16).toString('hex'),
  });

  it('signup, login lookup, then password reset', async () => {
    const d = deps();
    const { challengeId } = await requestOtp(d, { phone: '771234567', purpose: 'signup' }, '1.1.1.1');
    const signup = await completeSignup(d, { challengeId, code: sent.at(-1)!.code, password: 'secret1', profile: profile('ali_1') }, '1.1.1.1');
    expect(await signInWithPassword(signup.email, 'secret1')).toBe(true);

    expect((await lookupLoginEmail(d, { identifier: 'ALI_1' }, '1.1.1.1')).email).toBe(signup.email);
    expect((await lookupLoginEmail(d, { identifier: '771234567' }, '1.1.1.1')).email).toBe(signup.email);

    // the used signup challenge cannot be replayed, nor used for a reset
    await expect(resetPassword(d, { challengeId, code: sent.at(-1)!.code, newPassword: 'hacked1' }, '1.1.1.1')).rejects.toBeInstanceOf(AppError);

    // reset (cooldown is per phone, so use a fresh deps clock)
    const base = Date.now() + 61_000;
    const later: Deps = { ...d, now: () => base };
    const reset = await requestOtp(later, { phone: '771234567', purpose: 'reset' }, '1.1.1.1');
    await resetPassword(later, { challengeId: reset.challengeId, code: sent.at(-1)!.code, newPassword: 'brandnew1' }, '1.1.1.1');
    expect(await signInWithPassword(signup.email, 'brandnew1')).toBe(true);
    expect(await signInWithPassword(signup.email, 'secret1')).toBe(false);
  });
});

describe('account deletion with real stores', () => {
  it('removes profile, history, notifications, username claim, image hook and auth user, and only for that user', async () => {
    const a = await dir.createAccount({ phone: '771234567', password: 'secret1', profile: profile('alice') });
    const b = await dir.createAccount({ phone: '700000000', password: 'secret1', profile: profile('bob') });
    for (const u of [a, b]) {
      await db.collection('users').doc(u.uid).collection('notifications').doc('n1').set({ t: 1 });
      await db.collection('exams').doc(u.uid).collection('userExams').doc('e1').set({ points: 5 });
    }
    const images: string[] = [];
    const data = new FirebaseAccountData(auth, db, async (uid) => { images.push(uid); });
    const now = Date.now();

    await deleteAccount({ data, now: () => now }, { uid: a.uid, authTimeSec: Math.floor(now / 1000) });

    expect((await db.collection('users').doc(a.uid).get()).exists).toBe(false);
    expect((await db.collection('users').doc(a.uid).collection('notifications').get()).size).toBe(0);
    expect((await db.collection('exams').doc(a.uid).collection('userExams').get()).size).toBe(0);
    expect((await db.collection('usernames').doc('alice').get()).exists).toBe(false);
    await expect(auth.getUser(a.uid)).rejects.toMatchObject({ code: 'auth/user-not-found' });
    expect(images).toEqual([a.uid]);

    // the other user is untouched
    expect((await db.collection('users').doc(b.uid).get()).exists).toBe(true);
    expect((await db.collection('exams').doc(b.uid).collection('userExams').get()).size).toBe(1);
    expect((await db.collection('usernames').doc('bob').get()).exists).toBe(true);
    expect((await auth.getUser(b.uid)).uid).toBe(b.uid);
  });

  it('can be retried after the auth user is already gone', async () => {
    const a = await dir.createAccount({ phone: '771234567', password: 'secret1', profile: profile('alice') });
    await auth.deleteUser(a.uid);
    const data = new FirebaseAccountData(auth, db, async () => {});
    const now = Date.now();
    await deleteAccount({ data, now: () => now }, { uid: a.uid, authTimeSec: Math.floor(now / 1000) });
    expect((await db.collection('users').doc(a.uid).get()).exists).toBe(false);
  });
});
