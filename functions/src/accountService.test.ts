import { describe, expect, it } from 'vitest';
import { AccountData, RECENT_LOGIN_MS, deleteAccount } from './accountService';
import { AppError } from './validation';

const NOW = 1_700_000_000_000;

function setup(over: Partial<AccountData> = {}) {
  const calls: string[] = [];
  const data: AccountData = {
    deleteUserData: async (uid) => { calls.push(`data:${uid}`); },
    deleteAuthUser: async (uid) => { calls.push(`auth:${uid}`); },
    ...over,
  };
  return { calls, deps: { data, now: () => NOW } };
}
const secs = (msAgo: number) => Math.floor((NOW - msAgo) / 1000);
async function fails(p: Promise<unknown>) {
  try { await p; } catch (e) { return e as AppError; }
  throw new Error('expected rejection');
}

describe('deleteAccount', () => {
  it('deletes the data first, then the auth user', async () => {
    const { calls, deps } = setup();
    await deleteAccount(deps, { uid: 'u1', authTimeSec: secs(1000) });
    expect(calls).toEqual(['data:u1', 'auth:u1']);
  });

  it('rejects callers who are not signed in', async () => {
    const { calls, deps } = setup();
    const e = await fails(deleteAccount(deps, { authTimeSec: secs(0) }));
    expect(e.code).toBe('permission-denied');
    expect(calls).toEqual([]);
  });

  it('requires a recent login (re-authentication)', async () => {
    const { calls, deps } = setup();
    const e = await fails(deleteAccount(deps, { uid: 'u1', authTimeSec: secs(RECENT_LOGIN_MS + 5000) }));
    expect(e.code).toBe('failed-precondition');
    expect(e.message).toBe('recent-login-required');
    expect(calls).toEqual([]);
  });

  it('treats a missing auth time as not recent', async () => {
    const { deps } = setup();
    expect((await fails(deleteAccount(deps, { uid: 'u1' }))).message).toBe('recent-login-required');
  });

  it('keeps the auth user when data deletion fails, so the call can be retried', async () => {
    const { calls, deps } = setup({ deleteUserData: async () => { throw new Error('firestore down'); } });
    await expect(deleteAccount(deps, { uid: 'u1', authTimeSec: secs(0) })).rejects.toThrow('firestore down');
    expect(calls).toEqual([]);
  });
});
