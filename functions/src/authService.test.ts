import { beforeEach, describe, expect, it } from 'vitest';
import { AppError } from './validation';
import { Challenge, Counter, MemoryStore } from './types';
import { Deps, OtpSender, UserDirectory, checkAvailability, completeSignup, lookupLoginEmail, requestOtp, resetPassword } from './authService';
import { MAX_ATTEMPTS } from './otp';

class FakeDirectory implements UserDirectory {
  accounts = new Map<string, { uid: string; email: string; password: string }>(); // by phone
  usernames = new Map<string, string>(); // username(lower) -> phone
  revoked: string[] = [];
  async phoneExists(p: string) { return this.accounts.has(p); }
  async usernameExists(u: string) { return this.usernames.has(u.toLowerCase()); }
  async findAccountByPhone(p: string) { const a = this.accounts.get(p); return a ? { uid: a.uid, email: a.email } : null; }
  async usernameToPhone(u: string) { return this.usernames.get(u.toLowerCase()) ?? null; }
  async createAccount(a: { phone: string; password: string; profile: { userName: string } }) {
    const email = `${a.phone}@users.falih.invalid`;
    this.accounts.set(a.phone, { uid: `uid-${a.phone}`, email, password: a.password });
    this.usernames.set(a.profile.userName.toLowerCase(), a.phone);
    return { uid: `uid-${a.phone}`, email };
  }
  async setPassword(uid: string, password: string) {
    for (const a of this.accounts.values()) if (a.uid === uid) a.password = password;
    this.revoked.push(uid);
  }
}

class FakeSender implements OtpSender {
  sent: { phone: string; code: string }[] = [];
  fail = false;
  async send(phone: string, code: string) {
    if (this.fail) throw new Error('relay down');
    this.sent.push({ phone, code });
  }
}

let now = 1_000_000;
let n = 0;
let dir: FakeDirectory;
let sender: FakeSender;
let deps: Deps;
const PROFILE = { fullName: 'Ali', userName: 'Ali_1', schoolName: 'S' };

beforeEach(() => {
  now = 1_000_000;
  n = 0;
  dir = new FakeDirectory();
  sender = new FakeSender();
  deps = {
    challenges: new MemoryStore<Challenge>(),
    limits: new MemoryStore<Counter>(),
    users: dir,
    sender,
    pepper: 'pepper',
    decoySecret: 'decoy',
    now: () => now,
    newId: () => `id${++n}`,
    newCode: () => '482913',
  };
});

const code = (e: unknown) => (e as AppError).code;
const msg = (e: unknown) => (e as AppError).message;
async function fails(p: Promise<unknown>) {
  try { await p; } catch (e) { return e as AppError; }
  throw new Error('expected rejection');
}

async function signup(phone = '771234567') {
  const { challengeId } = await requestOtp(deps, { phone, purpose: 'signup' }, '1.1.1.1');
  return completeSignup(deps, { challengeId, code: '482913', password: 'secret1', profile: PROFILE }, '1.1.1.1');
}

describe('requestOtp', () => {
  it('sends the code over the sender and returns only a challenge id', async () => {
    const r = await requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip');
    expect(sender.sent).toEqual([{ phone: '771234567', code: '482913' }]);
    expect(JSON.stringify(r)).not.toContain('482913');
    expect(r.challengeId).toBe('id1');
  });
  it('rejects malformed phones', async () => {
    expect(code(await fails(requestOtp(deps, { phone: '123', purpose: 'signup' }, 'ip')))).toBe('invalid-argument');
  });
  it('rejects signup for a phone that already has an account', async () => {
    await signup();
    now += 61_000;
    expect(code(await fails(requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip')))).toBe('already-exists');
  });
  it('denies a resend inside the 60 second cooldown', async () => {
    await requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip');
    expect(code(await fails(requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip')))).toBe('resource-exhausted');
    now += 61_000;
    await requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip');
  });
  it('limits one phone to five codes per hour', async () => {
    for (let i = 0; i < 5; i++) { await requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip'); now += 61_000; }
    expect(code(await fails(requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip')))).toBe('resource-exhausted');
  });
  it('limits one ip across many phones', async () => {
    for (let i = 0; i < 20; i++) await requestOtp(deps, { phone: `77123${String(1000 + i)}`, purpose: 'signup' }, 'same');
    expect(code(await fails(requestOtp(deps, { phone: '779999999', purpose: 'signup' }, 'same')))).toBe('resource-exhausted');
  });
  it('reset for an unregistered phone looks identical but sends nothing', async () => {
    const r = await requestOtp(deps, { phone: '700000000', purpose: 'reset' }, 'ip');
    expect(r.challengeId).toBeTruthy();
    expect(r.expiresInSec).toBe(300);
    expect(sender.sent).toHaveLength(0);
  });
  it('a sender failure surfaces as unavailable and the challenge is unusable', async () => {
    sender.fail = true;
    expect(code(await fails(requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip')))).toBe('unavailable');
    sender.fail = false;
    const e = await fails(completeSignup(deps, { challengeId: 'id1', code: '482913', password: 'secret1', profile: PROFILE }, 'ip'));
    expect(code(e)).toBe('failed-precondition');
  });
});

describe('completeSignup', () => {
  it('creates the account and returns the login email, not the code', async () => {
    const r = await signup();
    expect(r.email).toBe('771234567@users.falih.invalid');
    expect(dir.accounts.get('771234567')!.password).toBe('secret1');
  });
  it('binds the phone to the challenge, not to client input', async () => {
    await signup('771234567');
    expect(dir.accounts.has('771234567')).toBe(true);
    expect(dir.accounts.size).toBe(1);
  });
  it('rejects a wrong code without creating anything', async () => {
    const { challengeId } = await requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip');
    const e = await fails(completeSignup(deps, { challengeId, code: '000000', password: 'secret1', profile: PROFILE }, 'ip'));
    expect(code(e)).toBe('permission-denied');
    expect(dir.accounts.size).toBe(0);
  });
  it('locks after repeated wrong codes even if the right one follows', async () => {
    const { challengeId } = await requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip');
    for (let i = 0; i < MAX_ATTEMPTS; i++) await fails(completeSignup(deps, { challengeId, code: '000000', password: 'secret1', profile: PROFILE }, 'ip'));
    const e = await fails(completeSignup(deps, { challengeId, code: '482913', password: 'secret1', profile: PROFILE }, 'ip'));
    expect(code(e)).toBe('failed-precondition');
    expect(dir.accounts.size).toBe(0);
  });
  it('rejects a taken username before burning the code', async () => {
    dir.usernames.set('ali_1', '700000001');
    const { challengeId } = await requestOtp(deps, { phone: '771234567', purpose: 'signup' }, 'ip');
    const e = await fails(completeSignup(deps, { challengeId, code: '482913', password: 'secret1', profile: PROFILE }, 'ip'));
    expect(code(e)).toBe('already-exists');
    expect(msg(e)).toBe('username-taken');
    dir.usernames.clear();
    await completeSignup(deps, { challengeId, code: '482913', password: 'secret1', profile: PROFILE }, 'ip');
  });
  it('a reset challenge cannot create an account', async () => {
    await signup('700000000');
    now += 61_000;
    const { challengeId } = await requestOtp(deps, { phone: '700000000', purpose: 'reset' }, 'ip');
    const e = await fails(completeSignup(deps, { challengeId, code: '482913', password: 'secret1', profile: { ...PROFILE, userName: 'other' } }, 'ip'));
    expect(code(e)).toBe('failed-precondition');
  });
});

describe('resetPassword', () => {
  it('changes the password and revokes sessions', async () => {
    await signup();
    now += 61_000;
    const { challengeId } = await requestOtp(deps, { phone: '771234567', purpose: 'reset' }, 'ip');
    await resetPassword(deps, { challengeId, code: '482913', newPassword: 'newpass1' }, 'ip');
    expect(dir.accounts.get('771234567')!.password).toBe('newpass1');
    expect(dir.revoked).toContain('uid-771234567');
  });
  it('a signup challenge cannot reset a password', async () => {
    await signup();
    now += 61_000;
    const { challengeId } = await requestOtp(deps, { phone: '779999999', purpose: 'signup' }, 'ip');
    const e = await fails(resetPassword(deps, { challengeId, code: '482913', newPassword: 'newpass1' }, 'ip'));
    expect(code(e)).toBe('failed-precondition');
  });
  it('a decoy challenge for an unknown phone fails exactly like a wrong code', async () => {
    const { challengeId } = await requestOtp(deps, { phone: '700000000', purpose: 'reset' }, 'ip');
    const e = await fails(resetPassword(deps, { challengeId, code: '482913', newPassword: 'newpass1' }, 'ip'));
    expect(code(e)).toBe('permission-denied');
    expect(msg(e)).toBe('otp-invalid');
  });
  it('rejects a weak password before touching the code', async () => {
    await signup();
    now += 61_000;
    const { challengeId } = await requestOtp(deps, { phone: '771234567', purpose: 'reset' }, 'ip');
    expect(code(await fails(resetPassword(deps, { challengeId, code: '482913', newPassword: '123' }, 'ip')))).toBe('invalid-argument');
    await resetPassword(deps, { challengeId, code: '482913', newPassword: 'newpass1' }, 'ip');
  });
});

describe('lookupLoginEmail', () => {
  it('resolves a phone to the stored email (works for legacy gmail accounts)', async () => {
    dir.accounts.set('771234567', { uid: 'u', email: '771234567@gmail.com', password: 'x' });
    expect((await lookupLoginEmail(deps, { identifier: '771234567' }, 'ip')).email).toBe('771234567@gmail.com');
  });
  it('resolves a username through its phone', async () => {
    await signup();
    expect((await lookupLoginEmail(deps, { identifier: 'ALI_1' }, 'ip')).email).toBe('771234567@users.falih.invalid');
  });
  it('returns a stable decoy for unknown identifiers instead of an error', async () => {
    const a = await lookupLoginEmail(deps, { identifier: 'ghost' }, 'ip');
    const b = await lookupLoginEmail(deps, { identifier: 'ghost' }, 'ip');
    const c = await lookupLoginEmail(deps, { identifier: 'other' }, 'ip');
    expect(a.email).toMatch(/^nouser-[0-9a-f]{16}@users\.falih\.invalid$/);
    expect(a.email).toBe(b.email);
    expect(a.email).not.toBe(c.email);
  });
  it('is rate limited per ip', async () => {
    for (let i = 0; i < 60; i++) await lookupLoginEmail(deps, { identifier: 'ghost' }, 'ip');
    expect(code(await fails(lookupLoginEmail(deps, { identifier: 'ghost' }, 'ip')))).toBe('resource-exhausted');
  });
});

describe('checkAvailability', () => {
  it('reports taken usernames and phones', async () => {
    await signup();
    expect(await checkAvailability(deps, { userName: 'ali_1', phone: '771234567' }, 'ip')).toEqual({ userNameTaken: true, phoneTaken: true });
    expect(await checkAvailability(deps, { userName: 'free_name', phone: '700000000' }, 'ip')).toEqual({ userNameTaken: false, phoneTaken: false });
  });
});
