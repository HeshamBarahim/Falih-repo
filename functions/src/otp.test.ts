import { describe, expect, it } from 'vitest';
import { OtpProvider, issueChallenge, verifyChallenge, OTP_TTL_MS, MAX_ATTEMPTS } from './otp';
import { Challenge, MemoryStore } from './types';

const T0 = 1_000_000;

/** Provider whose single pending code is '123456'; a correct check spends it. */
function provider(over: Partial<OtpProvider> = {}): OtpProvider & { calls: number } {
  let live = true;
  const p = {
    calls: 0,
    send: async () => {},
    check: async (_phone: string, code: string) => {
      p.calls++;
      const ok = live && code === '123456';
      if (ok) live = false;
      return ok;
    },
    ...over,
  };
  return p;
}

async function setup() {
  const store = new MemoryStore<Challenge>();
  await issueChallenge(store, { id: 'c1', phone: '771234567', purpose: 'signup', now: T0 });
  return store;
}
const verify = (
  store: MemoryStore<Challenge>,
  prov: OtpProvider,
  code: string,
  over: Partial<{ now: number; purpose: 'signup' | 'reset' }> = {},
) => verifyChallenge(store, prov, { id: 'c1', code, purpose: over.purpose ?? 'signup', now: over.now ?? T0 + 1000 });

describe('challenge storage', () => {
  it('stores no code material at all', async () => {
    const c = (await setup()).data.get('c1')!;
    expect(Object.keys(c).sort()).toEqual(['attempts', 'consumed', 'createdAt', 'expiresAt', 'phone', 'purpose']);
    expect(c.expiresAt).toBe(T0 + OTP_TTL_MS);
  });
});

describe('verifyChallenge', () => {
  it('accepts the right code once and returns the phone', async () => {
    const store = await setup();
    const p = provider();
    expect(await verify(store, p, '123456')).toEqual({ status: 'ok', phone: '771234567' });
    expect((await verify(store, p, '123456')).status).toBe('consumed');
  });
  it('only one of many concurrent verifications wins even if the provider says yes to all', async () => {
    const store = await setup();
    const p = provider({ check: async () => true });
    const r = await Promise.all(Array.from({ length: 10 }, () => verify(store, p, '123456')));
    expect(r.filter((x) => x.status === 'ok')).toHaveLength(1);
  });
  it('counts wrong attempts, locks after the limit and then never asks the provider', async () => {
    const store = await setup();
    const p = provider();
    for (let i = 0; i < MAX_ATTEMPTS; i++) expect((await verify(store, p, '000000')).status).toBe('invalid');
    expect((await verify(store, p, '123456')).status).toBe('locked');
    expect(p.calls).toBe(MAX_ATTEMPTS);
  });
  it('rejects after expiry without asking the provider', async () => {
    const store = await setup();
    const p = provider();
    expect((await verify(store, p, '123456', { now: T0 + OTP_TTL_MS + 1 })).status).toBe('expired');
    expect(p.calls).toBe(0);
  });
  it('rejects a challenge used for a different purpose', async () => {
    const store = await setup();
    expect((await verify(store, provider(), '123456', { purpose: 'reset' })).status).toBe('wrong-purpose');
  });
  it('reports unknown ids as not-found', async () => {
    const store = new MemoryStore<Challenge>();
    expect((await verifyChallenge(store, provider(), { id: 'nope', code: '1', purpose: 'signup', now: T0 })).status).toBe('not-found');
  });
  it('a provider outage propagates and still costs one attempt', async () => {
    const store = await setup();
    const p = provider({ check: async () => { throw new Error('down'); } });
    await expect(verify(store, p, '123456')).rejects.toThrow('down');
    expect(store.data.get('c1')!.attempts).toBe(1);
  });
});
