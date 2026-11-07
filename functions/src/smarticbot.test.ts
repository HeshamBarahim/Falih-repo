import { beforeEach, describe, expect, it, vi } from 'vitest';
import { SmarticbotOtp } from './smarticbot';
import { AppError } from './validation';

const log = vi.hoisted(() => ({ error: vi.fn(), info: vi.fn() }));
vi.mock('firebase-functions/v2', () => ({ logger: log }));

const KEY = 'sk_secret_value';
let calls: { url: string; init: RequestInit }[];
let reply: { status: number; body?: unknown } | Error;

const fakeFetch = (async (url: string, init: RequestInit) => {
  calls.push({ url, init });
  if (reply instanceof Error) throw reply;
  return new Response(JSON.stringify(reply.body ?? {}), { status: reply.status });
}) as unknown as typeof fetch;

const make = (key = KEY) => new SmarticbotOtp(key, 'https://x.test/api/v1', fakeFetch);
const errOf = async (p: Promise<unknown>) => { try { await p; } catch (e) { return e as AppError; } throw new Error('no rejection'); };

beforeEach(() => { calls = []; reply = { status: 202, body: { success: true, data: { expires_in_seconds: 300 } } }; log.error.mockClear(); log.info.mockClear(); });

describe('send', () => {
  it('posts the international number with the key and idempotency header', async () => {
    await make().send('771234567', 'chal-1');
    expect(calls[0].url).toBe('https://x.test/api/v1/send-otp');
    const h = calls[0].init.headers as Record<string, string>;
    expect(h['x-api-key']).toBe(KEY);
    expect(h['Idempotency-Key']).toBe('chal-1');
    expect(JSON.parse(calls[0].init.body as string)).toEqual({ number: '967771234567' });
  });
  it.each([[429, 'resource-exhausted', 'too-many-requests'], [401, 'unavailable', 'otp-provider-misconfigured'], [502, 'unavailable', 'otp-send-failed'], [422, 'unavailable', 'otp-send-failed']])(
    'maps %i to %s/%s', async (status, code, message) => {
      reply = { status, body: { success: false, code: 'X' } };
      const e = await errOf(make().send('771234567', 'k'));
      expect([e.code, e.message]).toEqual([code, message]);
    });
  it('maps a network failure to otp-send-failed', async () => {
    reply = new TypeError('fetch failed');
    expect((await errOf(make().send('771234567', 'k'))).message).toBe('otp-send-failed');
  });
  it('refuses to call with an empty key', async () => {
    expect((await errOf(make('').send('771234567', 'k'))).message).toBe('otp-provider-misconfigured');
    expect(calls).toHaveLength(0);
  });
});

describe('check', () => {
  it('is true only for success with verified=true', async () => {
    reply = { status: 200, body: { success: true, data: { verified: true } } };
    expect(await make().check('771234567', '123456')).toBe(true);
    expect(JSON.parse(calls[0].init.body as string)).toEqual({ number: '967771234567', code: '123456' });
  });
  it.each([[{ success: true, data: { verified: false } }], [{ success: true }], [{}], [{ data: { verified: true } }]])('is false for %j', async (body) => {
    reply = { status: 200, body };
    expect(await make().check('771234567', '1')).toBe(false);
  });
  it.each([400, 404, 409, 410, 422])('treats %i as a wrong code', async (status) => {
    reply = { status, body: { success: false, code: 'bad' } };
    expect(await make().check('771234567', '1')).toBe(false);
  });
  it.each([401, 429, 500, 503])('treats %i as an outage, not a wrong code', async (status) => {
    reply = { status };
    await expect(make().check('771234567', '1')).rejects.toBeInstanceOf(AppError);
  });
});

it('never logs the key, the phone or the code', async () => {
  reply = { status: 502, body: { success: false, code: 'UPSTREAM' } };
  await errOf(make().send('771234567', 'k'));
  await make().check('771234567', '654321').catch(() => {});
  const logged = JSON.stringify([log.error.mock.calls, log.info.mock.calls]);
  for (const secret of [KEY, '771234567', '654321']) expect(logged).not.toContain(secret);
});
