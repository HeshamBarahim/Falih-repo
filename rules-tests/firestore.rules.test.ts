import { readFileSync } from 'node:fs';
import { RulesTestEnvironment, assertFails, assertSucceeds, initializeTestEnvironment } from '@firebase/rules-unit-testing';
import { Timestamp, collection, deleteDoc, doc, getDoc, getDocs, setDoc, updateDoc } from 'firebase/firestore';
import { afterAll, beforeAll, beforeEach, describe, it } from 'vitest';

let env: RulesTestEnvironment;

const USER = {
  FullName: 'Ali', UserName: 'ali_1', Phone: '771234567', fakeEmail: '771234567@users.falih.invalid',
  IsVerified: 'true', 'School Name': 'S', Governoroate: 'Sanaa', Grade: '12', Department: 'Science',
  Gender: 'M', userProfileImgUrl: '', deviceToken: 'tok',
};

const exam = (over: Record<string, unknown> = {}) => ({
  examName: 'Math', grade: '12', department: 'Science', examType: 'UnitExam', score: 20,
  totalQuestions: 10, correctAnswers: 10, wrongAnswers: 0, points: 17, timeTaken: '00:05:00',
  date: Timestamp.now(), answers: [0, 1, 2, 3, 0, 1, 2, 3, 0, 1], ...over,
});

beforeAll(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-falih',
    firestore: { rules: readFileSync('../firestore.rules', 'utf8') },
  });
});
afterAll(async () => env.cleanup());

beforeEach(async () => {
  await env.clearFirestore();
  await env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await setDoc(doc(db, 'users/alice'), USER);
    await setDoc(doc(db, 'users/bob'), { ...USER, UserName: 'bob', Phone: '700000000' });
    await setDoc(doc(db, 'leaderboard/current-month'), { leaderboard: [] });
    await setDoc(doc(db, 'plans/p1'), { name: 'Plan' });
    await setDoc(doc(db, 'subjects_science_12/math_12'), { units: [] });
    await setDoc(doc(db, 'secret_stuff/x'), { v: 1 });
    await setDoc(doc(db, 'app_config/version'), { VersionCode: '1' });
    await setDoc(doc(db, 'otp_challenges/c1'), { codeHash: 'x' });
  });
});

const alice = () => env.authenticatedContext('alice').firestore();
const anon = () => env.unauthenticatedContext().firestore();

describe('users', () => {
  it('lets an owner read their own profile', () => assertSucceeds(getDoc(doc(alice(), 'users/alice'))));
  it('blocks reading another user', () => assertFails(getDoc(doc(alice(), 'users/bob'))));
  it('blocks anonymous reads', () => assertFails(getDoc(doc(anon(), 'users/alice'))));
  it('blocks listing the collection (no scraping of phones)', () => assertFails(getDocs(collection(alice(), 'users'))));
  it('blocks queries by phone or username before login', () => assertFails(getDocs(collection(anon(), 'users'))));
  it('blocks client-side profile creation', () => assertFails(setDoc(doc(env.authenticatedContext('carol').firestore(), 'users/carol'), USER)));
  it('blocks client-side deletion', () => assertFails(deleteDoc(doc(alice(), 'users/alice'))));

  it('allows editing profile fields and the device token', () =>
    assertSucceeds(updateDoc(doc(alice(), 'users/alice'), { 'School Name': 'New', deviceToken: 'new', userProfileImgUrl: 'u' })));
  it('allows the legacy full-document update when identity fields are unchanged', () =>
    assertSucceeds(updateDoc(doc(alice(), 'users/alice'), { ...USER, 'School Name': 'Changed' })));
  it('allows set+merge of the device token (existing doc)', () =>
    assertSucceeds(setDoc(doc(alice(), 'users/alice'), { deviceToken: 'x' }, { merge: true })));

  it.each(['Phone', 'UserName', 'IsVerified', 'fakeEmail'])('blocks changing %s', (field) =>
    assertFails(updateDoc(doc(alice(), 'users/alice'), { [field]: 'hacked' })));
  it('blocks adding unknown fields such as points or premium flags', () =>
    assertFails(updateDoc(doc(alice(), 'users/alice'), { isPremium: true })));
  it("blocks editing someone else's profile", () => assertFails(updateDoc(doc(alice(), 'users/bob'), { Grade: '1' })));
});

describe('notifications', () => {
  it('owner can create, read, delete', async () => {
    const ref = doc(alice(), 'users/alice/notifications/n1');
    await assertSucceeds(setDoc(ref, { title: 't' }));
    await assertSucceeds(getDoc(ref));
    await assertSucceeds(deleteDoc(ref));
  });
  it("others cannot read or write", async () => {
    await assertFails(getDoc(doc(env.authenticatedContext('bob').firestore(), 'users/alice/notifications/n1')));
    await assertFails(setDoc(doc(env.authenticatedContext('bob').firestore(), 'users/alice/notifications/n1'), { title: 'x' }));
  });
});

describe('exam results', () => {
  const ref = (db = alice()) => doc(collection(db, 'exams/alice/userExams'));
  it('accepts a valid result for the owner', () => assertSucceeds(setDoc(ref(), exam())));
  it('accepts a valid final exam at the maximum points', () =>
    assertSucceeds(setDoc(ref(), exam({ examType: 'FinalExam', totalQuestions: 50, correctAnswers: 50, score: 100, points: 118, answers: new Array(50).fill(0) }))));
  it('rejects writing into another user history', () => assertFails(setDoc(doc(collection(alice(), 'exams/bob/userExams')), exam())));
  it('rejects forged points', () => assertFails(setDoc(ref(), exam({ points: 9999 }))));
  it('rejects a score above the possible maximum', () => assertFails(setDoc(ref(), exam({ score: 500 }))));
  it('rejects more correct answers than questions', () => assertFails(setDoc(ref(), exam({ correctAnswers: 11 }))));
  it('rejects unknown extra fields', () => assertFails(setDoc(ref(), exam({ bonus: 1 }))));
  it('rejects an unknown exam type', () => assertFails(setDoc(ref(), exam({ examType: 'Cheat' }))));
  it('rejects a backdated result', () => assertFails(setDoc(ref(), exam({ date: Timestamp.fromMillis(Date.now() - 3 * 86_400_000) }))));
  it('rejects edits and deletes of a saved result', async () => {
    const r = ref();
    await assertSucceeds(setDoc(r, exam()));
    await assertFails(updateDoc(r, { points: 100 }));
    await assertFails(deleteDoc(r));
  });
  it('lets only the owner read their history', async () => {
    const r = ref();
    await assertSucceeds(setDoc(r, exam()));
    await assertSucceeds(getDoc(r));
    await assertFails(getDoc(doc(env.authenticatedContext('bob').firestore(), r.path)));
  });
});

describe('shared read-only data', () => {
  it('signed-in users read the leaderboard and plans', async () => {
    await assertSucceeds(getDoc(doc(alice(), 'leaderboard/current-month')));
    await assertSucceeds(getDocs(collection(alice(), 'plans')));
  });
  it('anonymous users cannot', async () => {
    await assertFails(getDoc(doc(anon(), 'leaderboard/current-month')));
    await assertFails(getDocs(collection(anon(), 'plans')));
  });
  it('nobody writes leaderboard or plans from the client', async () => {
    await assertFails(setDoc(doc(alice(), 'leaderboard/current-month'), { leaderboard: [{ points: 9999 }] }));
    await assertFails(setDoc(doc(alice(), 'plans/p2'), { name: 'free' }));
  });
  it('signed-in users read question banks; anonymous cannot', async () => {
    await assertSucceeds(getDoc(doc(alice(), 'subjects_science_12/math_12')));
    await assertFails(getDoc(doc(anon(), 'subjects_science_12/math_12')));
  });
  it('unlisted collections stay closed', () => assertFails(getDoc(doc(alice(), 'secret_stuff/x'))));
  it('app_config is readable before login but never writable', async () => {
    await assertSucceeds(getDocs(collection(anon(), 'app_config')));
    await assertFails(setDoc(doc(alice(), 'app_config/version'), { VersionCode: '0' }));
  });
});

describe('server-only collections', () => {
  it.each(['otp_challenges/c1', 'rate_limits/k', 'usernames/ali_1'])('%s is closed to clients', async (path) => {
    await assertFails(getDoc(doc(alice(), path)));
    await assertFails(setDoc(doc(alice(), path), { a: 1 }));
    await assertFails(getDoc(doc(anon(), path)));
  });
});
