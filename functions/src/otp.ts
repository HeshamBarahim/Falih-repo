import { createHmac, randomInt, timingSafeEqual } from 'node:crypto';
import { Challenge, KeyedStore, Purpose } from './types';

export const OTP_TTL_MS = 5 * 60_000;
export const MAX_ATTEMPTS = 5;

export function generateCode(): string {
  return String(randomInt(100000, 1000000));
}

export function hashCode(pepper: string, id: string, code: string): string {
  return createHmac('sha256', pepper).update(`${id}:${code}`).digest('hex');
}

export async function issueChallenge(
  store: KeyedStore<Challenge>,
  a: { id: string; phone: string; purpose: Purpose; code: string; pepper: string; now: number },
): Promise<void> {
  await store.mutate(a.id, () => ({
    next: {
      phone: a.phone,
      purpose: a.purpose,
      codeHash: hashCode(a.pepper, a.id, a.code),
      createdAt: a.now,
      expiresAt: a.now + OTP_TTL_MS,
      attempts: 0,
      consumed: false,
    },
    result: undefined,
  }));
}

export type VerifyResult =
  | { status: 'ok'; phone: string }
  | { status: 'invalid' | 'expired' | 'locked' | 'not-found' | 'consumed' | 'wrong-purpose' };

export function verifyChallenge(
  store: KeyedStore<Challenge>,
  a: { id: string; code: string; purpose: Purpose; pepper: string; now: number },
): Promise<VerifyResult> {
  return store.mutate<VerifyResult>(a.id, (c) => {
    if (!c) return { result: { status: 'not-found' } };
    if (c.consumed) return { result: { status: 'consumed' } };
    if (c.purpose !== a.purpose) return { result: { status: 'wrong-purpose' } };
    if (a.now > c.expiresAt) return { result: { status: 'expired' } };
    if (c.attempts >= MAX_ATTEMPTS) return { result: { status: 'locked' } };
    const expected = Buffer.from(c.codeHash, 'hex');
    const given = Buffer.from(hashCode(a.pepper, a.id, a.code), 'hex');
    const match = expected.length === given.length && timingSafeEqual(expected, given);
    if (!match) return { next: { ...c, attempts: c.attempts + 1 }, result: { status: 'invalid' } };
    return { next: { ...c, attempts: c.attempts + 1, consumed: true }, result: { status: 'ok', phone: c.phone } };
  });
}
