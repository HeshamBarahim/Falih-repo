import { createHmac } from 'node:crypto';
import { OTP_TTL_MS, OtpProvider, VerifyResult, issueChallenge, verifyChallenge } from './otp';
import { Limit, allow } from './rateLimit';
import { Challenge, Counter, KeyedStore, Purpose } from './types';
import { AppError, Profile, normalizePhone, parseProfile, validatePassword } from './validation';

export interface Account {
  uid: string;
  email: string;
}

export interface UserDirectory {
  phoneExists(phone: string): Promise<boolean>;
  usernameExists(userName: string): Promise<boolean>;
  findAccountByPhone(phone: string): Promise<Account | null>;
  usernameToPhone(userName: string): Promise<string | null>;
  createAccount(a: { phone: string; password: string; profile: Profile }): Promise<Account>;
  /** Must also revoke the user's refresh tokens. */
  setPassword(uid: string, password: string): Promise<void>;
}

export interface Deps {
  challenges: KeyedStore<Challenge>;
  limits: KeyedStore<Counter>;
  users: UserDirectory;
  otp: OtpProvider;
  pepper: string;
  decoySecret: string;
  now(): number;
  newId(): string;
}

const HOUR = 3_600_000;
export const LIMITS = {
  otpPerIp: { max: 20, windowMs: HOUR },
  otpPerPhone: { max: 5, windowMs: HOUR },
  otpCooldown: { max: 1, windowMs: 60_000 },
  lookupPerIp: { max: 60, windowMs: HOUR },
  availabilityPerIp: { max: 60, windowMs: HOUR },
  verifyPerIp: { max: 60, windowMs: HOUR },
} as const satisfies Record<string, Limit>;

/** Domain for NEW accounts (never receives mail; the decoy for unknown logins uses it too, so both look alike). */
export const ACCOUNT_DOMAIN = 'users.falih.invalid';

async function guard(d: Deps, key: string, limit: Limit): Promise<void> {
  if (!(await allow(d.limits, key, limit, d.now()))) {
    throw new AppError('resource-exhausted', 'too-many-requests');
  }
}

function requirePhone(raw: unknown): string {
  const p = normalizePhone(raw);
  if (!p) throw new AppError('invalid-argument', 'phone-invalid');
  return p;
}

function requireString(raw: unknown, name: string): string {
  if (typeof raw !== 'string' || raw.length === 0 || raw.length > 128) {
    throw new AppError('invalid-argument', `${name}-invalid`);
  }
  return raw;
}

function failFor(r: Exclude<VerifyResult, { status: 'ok' }>): never {
  switch (r.status) {
    case 'invalid':
    case 'not-found':
      throw new AppError('permission-denied', 'otp-invalid');
    default:
      throw new AppError('failed-precondition', `otp-${r.status}`);
  }
}

async function verify(d: Deps, id: unknown, code: unknown, purpose: Purpose): Promise<string> {
  const r = await verifyChallenge(d.challenges, d.otp, {
    id: requireString(id, 'challengeId'),
    code: requireString(code, 'code'),
    purpose,
    now: d.now(),
  });
  if (r.status !== 'ok') failFor(r);
  return r.phone;
}

export async function requestOtp(
  d: Deps,
  input: { phone: unknown; purpose: unknown },
  ip: string,
): Promise<{ challengeId: string; expiresInSec: number }> {
  const phone = requirePhone(input.phone);
  if (input.purpose !== 'signup' && input.purpose !== 'reset') {
    throw new AppError('invalid-argument', 'purpose-invalid');
  }
  const purpose: Purpose = input.purpose;

  await guard(d, `otp-ip:${ip}`, LIMITS.otpPerIp);
  await guard(d, `otp-cool:${phone}`, LIMITS.otpCooldown);
  await guard(d, `otp-phone:${phone}`, LIMITS.otpPerPhone);

  const id = d.newId();
  const expiresInSec = OTP_TTL_MS / 1000;

  if (purpose === 'signup') {
    if (await d.users.phoneExists(phone)) throw new AppError('already-exists', 'phone-taken');
  } else if (!(await d.users.findAccountByPhone(phone))) {
    // Same response as the real path, nothing stored or sent: no account enumeration.
    return { challengeId: id, expiresInSec };
  }

  await issueChallenge(d.challenges, { id, phone, purpose, now: d.now() });
  try {
    await d.otp.send(phone, id);
  } catch (e) {
    // Burn the challenge so a code that may have been half-delivered is unusable.
    await d.challenges.mutate(id, (c) => (c ? { next: { ...c, consumed: true }, result: undefined } : { result: undefined }));
    if (e instanceof AppError) throw e;
    throw new AppError('unavailable', 'otp-send-failed');
  }
  return { challengeId: id, expiresInSec };
}

export async function completeSignup(
  d: Deps,
  input: { challengeId: unknown; code: unknown; password: unknown; profile: unknown },
  ip: string,
): Promise<{ email: string }> {
  const password = validatePassword(input.password);
  const profile = parseProfile(input.profile);
  await guard(d, `verify-ip:${ip}`, LIMITS.verifyPerIp);

  // Cheap uniqueness check first so a taken username does not burn the code.
  if (await d.users.usernameExists(profile.userName)) throw new AppError('already-exists', 'username-taken');

  const phone = await verify(d, input.challengeId, input.code, 'signup');
  if (await d.users.phoneExists(phone)) throw new AppError('already-exists', 'phone-taken');
  const account = await d.users.createAccount({ phone, password, profile });
  return { email: account.email };
}

export async function resetPassword(
  d: Deps,
  input: { challengeId: unknown; code: unknown; newPassword: unknown },
  ip: string,
): Promise<Record<string, never>> {
  const password = validatePassword(input.newPassword);
  await guard(d, `verify-ip:${ip}`, LIMITS.verifyPerIp);
  const phone = await verify(d, input.challengeId, input.code, 'reset');
  const account = await d.users.findAccountByPhone(phone);
  if (!account) throw new AppError('permission-denied', 'otp-invalid');
  await d.users.setPassword(account.uid, password);
  return {};
}

function decoyEmail(d: Deps, identifier: string): string {
  const h = createHmac('sha256', d.decoySecret).update(identifier.toLowerCase()).digest('hex').slice(0, 16);
  return `nouser-${h}@${ACCOUNT_DOMAIN}`;
}

export async function lookupLoginEmail(
  d: Deps,
  input: { identifier: unknown },
  ip: string,
): Promise<{ email: string }> {
  const identifier = requireString(input.identifier, 'identifier').trim();
  await guard(d, `lookup-ip:${ip}`, LIMITS.lookupPerIp);
  const phone = normalizePhone(identifier) ?? (await d.users.usernameToPhone(identifier));
  const account = phone ? await d.users.findAccountByPhone(phone) : null;
  return { email: account ? account.email : decoyEmail(d, identifier) };
}

export async function checkAvailability(
  d: Deps,
  input: { userName?: unknown; phone?: unknown },
  ip: string,
): Promise<{ userNameTaken?: boolean; phoneTaken?: boolean }> {
  await guard(d, `avail-ip:${ip}`, LIMITS.availabilityPerIp);
  const out: { userNameTaken?: boolean; phoneTaken?: boolean } = {};
  if (input.userName !== undefined) out.userNameTaken = await d.users.usernameExists(requireString(input.userName, 'userName').trim());
  if (input.phone !== undefined) out.phoneTaken = await d.users.phoneExists(requirePhone(input.phone));
  return out;
}
