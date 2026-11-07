import { logger } from 'firebase-functions/v2';
import { OtpProvider } from './otp';
import { AppError } from './validation';

export const SMARTICBOT_BASE = 'https://smarticbot.com/api/v1';
const TIMEOUT_MS = 15_000;
/** Yemen country code; the app only collects the 9-digit national number. */
const COUNTRY_CODE = '967';

type Fetch = typeof fetch;

interface ApiReply {
  success?: boolean;
  code?: string;
  data?: { verified?: boolean };
}

/**
 * Smarticbot OTP API (https://smarticbot.com/en/docs): POST /send-otp and /verify-otp, `x-api-key` header.
 * Smarticbot generates, delivers and checks the code. Logs never contain the key, the phone or the code.
 */
export class SmarticbotOtp implements OtpProvider {
  constructor(
    private readonly apiKey: string,
    private readonly base: string = SMARTICBOT_BASE,
    private readonly doFetch: Fetch = fetch,
  ) {}

  async send(phone: string, idempotencyKey: string): Promise<void> {
    const { status, body } = await this.call('send-otp', { number: COUNTRY_CODE + phone }, idempotencyKey);
    if (status === 202 || status === 200) return;
    this.fail('send-otp', status, body);
  }

  async check(phone: string, code: string): Promise<boolean> {
    const { status, body } = await this.call('verify-otp', { number: COUNTRY_CODE + phone, code });
    if (status === 200) return body.success === true && body.data?.verified === true;
    // Wrong, expired or already-used codes are client errors from the provider, not outages.
    if ([400, 404, 409, 410, 422].includes(status)) {
      logger.info('verify-otp rejected', { status, code: body.code });
      return false;
    }
    this.fail('verify-otp', status, body);
  }

  private async call(path: string, payload: object, idempotencyKey?: string): Promise<{ status: number; body: ApiReply }> {
    if (!this.apiKey) {
      logger.error('SMARTICBOT_API_KEY is empty');
      throw new AppError('unavailable', 'otp-provider-misconfigured');
    }
    let res: Response;
    try {
      res = await this.doFetch(`${this.base}/${path}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          accept: 'application/json',
          'x-api-key': this.apiKey,
          ...(idempotencyKey ? { 'Idempotency-Key': idempotencyKey } : {}),
        },
        body: JSON.stringify(payload),
        signal: AbortSignal.timeout(TIMEOUT_MS),
      });
    } catch (e) {
      logger.error('otp provider unreachable', { path, reason: e instanceof Error ? e.name : 'unknown' });
      throw new AppError('unavailable', 'otp-send-failed');
    }
    const body = (await res.json().catch(() => ({}))) as ApiReply;
    return { status: res.status, body };
  }

  private fail(path: string, status: number, body: ApiReply): never {
    logger.error('otp provider error', { path, status, code: body.code });
    if (status === 429) throw new AppError('resource-exhausted', 'too-many-requests');
    if (status === 401) throw new AppError('unavailable', 'otp-provider-misconfigured');
    throw new AppError('unavailable', 'otp-send-failed');
  }
}
