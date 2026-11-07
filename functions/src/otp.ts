import { Challenge, KeyedStore, Purpose } from './types';

export const OTP_TTL_MS = 5 * 60_000;
export const MAX_ATTEMPTS = 5;

/**
 * The OTP provider (Smarticbot) creates, delivers and checks the code. We never see or store it.
 * Our challenge document only carries what the provider cannot enforce for us: which phone and purpose the
 * client asked for, our own attempt budget and single-use consumption of the verified result.
 */
export interface OtpProvider {
  send(phone: string, idempotencyKey: string): Promise<void>;
  /** true only when the provider confirms the code is right (and thereby spends it). */
  check(phone: string, code: string): Promise<boolean>;
}

export async function issueChallenge(
  store: KeyedStore<Challenge>,
  a: { id: string; phone: string; purpose: Purpose; now: number },
): Promise<void> {
  await store.mutate(a.id, () => ({
    next: {
      phone: a.phone,
      purpose: a.purpose,
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

type Reservation = { ok: true; phone: string } | { ok: false; result: VerifyResult };

/**
 * 1. Atomically spend one attempt (so parallel guesses cannot exceed the budget).
 * 2. Ask the provider. 3. Atomically mark the challenge consumed; only one caller can win that step.
 */
export async function verifyChallenge(
  store: KeyedStore<Challenge>,
  provider: OtpProvider,
  a: { id: string; code: string; purpose: Purpose; now: number },
): Promise<VerifyResult> {
  const reservation = await store.mutate<Reservation>(a.id, (c) => {
    if (!c) return { result: { ok: false, result: { status: 'not-found' } } };
    if (c.consumed) return { result: { ok: false, result: { status: 'consumed' } } };
    if (c.purpose !== a.purpose) return { result: { ok: false, result: { status: 'wrong-purpose' } } };
    if (a.now > c.expiresAt) return { result: { ok: false, result: { status: 'expired' } } };
    if (c.attempts >= MAX_ATTEMPTS) return { result: { ok: false, result: { status: 'locked' } } };
    return { next: { ...c, attempts: c.attempts + 1 }, result: { ok: true, phone: c.phone } };
  });
  if (!reservation.ok) return reservation.result;

  if (!(await provider.check(reservation.phone, a.code))) return { status: 'invalid' };

  return store.mutate<VerifyResult>(a.id, (c) => {
    if (!c || c.consumed) return { result: { status: 'consumed' } };
    return { next: { ...c, consumed: true }, result: { status: 'ok', phone: c.phone } };
  });
}
