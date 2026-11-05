import { describe, expect, it } from 'vitest';
import { generateCode, hashCode, issueChallenge, verifyChallenge, OTP_TTL_MS, MAX_ATTEMPTS } from './otp';
import { Challenge, MemoryStore } from './types';

const pepper = 'pepper';
const T0 = 1_000_000;

async function setup(code = '123456') {
  const store = new MemoryStore<Challenge>();
  await issueChallenge(store, { id: 'c1', phone: '771234567', purpose: 'signup', code, pepper, now: T0 });
  return store;
}
const verify = (store: MemoryStore<Challenge>, code: string, over: Partial<{ now: number; purpose: 'signup' | 'reset' }> = {}) =>
  verifyChallenge(store, { id: 'c1', code, purpose: over.purpose ?? 'signup', pepper, now: over.now ?? T0 + 1000 });

describe('generateCode', () => {
  it('is always six digits', () => {
    for (let i = 0; i < 500; i++) expect(generateCode()).toMatch(/^[1-9]\d{5}$/);
  });
});

describe('challenge storage', () => {
  it('stores a hash, never the code', async () => {
    const store = await setup('908172'); // must not collide with the phone fixture
    const c = store.data.get('c1')!;
    expect(JSON.stringify(c)).not.toContain('908172');
    expect(c.codeHash).toBe(hashCode(pepper, 'c1', '908172'));
    expect(c.expiresAt).toBe(T0 + OTP_TTL_MS);
  });
});

describe('verifyChallenge', () => {
  it('accepts the right code once and returns the phone', async () => {
    const store = await setup();
    expect(await verify(store, '123456')).toEqual({ status: 'ok', phone: '771234567' });
    expect((await verify(store, '123456')).status).toBe('consumed');
  });
  it('only one of two concurrent correct verifications wins', async () => {
    const store = await setup();
    const r = await Promise.all([verify(store, '123456'), verify(store, '123456')]);
    expect(r.filter((x) => x.status === 'ok')).toHaveLength(1);
  });
  it('counts wrong attempts and locks after the limit even for the right code', async () => {
    const store = await setup();
    for (let i = 0; i < MAX_ATTEMPTS; i++) expect((await verify(store, '000000')).status).toBe('invalid');
    expect((await verify(store, '123456')).status).toBe('locked');
  });
  it('rejects after expiry', async () => {
    const store = await setup();
    expect((await verify(store, '123456', { now: T0 + OTP_TTL_MS + 1 })).status).toBe('expired');
  });
  it('rejects a challenge used for a different purpose', async () => {
    const store = await setup();
    expect((await verify(store, '123456', { purpose: 'reset' })).status).toBe('wrong-purpose');
  });
  it('reports unknown ids as not-found', async () => {
    const store = new MemoryStore<Challenge>();
    expect((await verifyChallenge(store, { id: 'nope', code: '1', purpose: 'signup', pepper, now: T0 })).status).toBe('not-found');
  });
});
