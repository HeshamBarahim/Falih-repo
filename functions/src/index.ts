import { createHmac, randomBytes } from 'node:crypto';
import { initializeApp } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { getFirestore } from 'firebase-admin/firestore';
import { defineBoolean, defineSecret } from 'firebase-functions/params';
import { logger } from 'firebase-functions/v2';
import { CallableOptions, CallableRequest, HttpsError, onCall } from 'firebase-functions/v2/https';
import { onSchedule } from 'firebase-functions/v2/scheduler';
import { Deps, checkAvailability, completeSignup, lookupLoginEmail, requestOtp, resetPassword } from './authService';
import { FirebaseDirectory } from './directory';
import { FirestoreStore } from './firestoreStores';
import { generateCode } from './otp';
import { Challenge, Counter } from './types';
import { AppError } from './validation';
import { WhatsAppSender } from './whatsapp';

initializeApp();
const db = getFirestore();

const OTP_PEPPER = defineSecret('OTP_PEPPER');
const WHATSAPP_API_URL = defineSecret('WHATSAPP_API_URL');
const WHATSAPP_API_KEY = defineSecret('WHATSAPP_API_KEY');
/** Flip to true once Play Integrity / App Check is registered and the app version using it is live. */
const ENFORCE_APP_CHECK = defineBoolean('ENFORCE_APP_CHECK', { default: false });

const options: CallableOptions = {
  region: 'us-central1',
  maxInstances: 10,
  secrets: [OTP_PEPPER, WHATSAPP_API_URL, WHATSAPP_API_KEY],
};

function deps(): Deps {
  const pepper = OTP_PEPPER.value();
  return {
    challenges: new FirestoreStore<Challenge>(db, 'otp_challenges'),
    limits: new FirestoreStore<Counter>(db, 'rate_limits'),
    users: new FirebaseDirectory(getAuth(), db),
    sender: new WhatsAppSender(WHATSAPP_API_URL.value(), WHATSAPP_API_KEY.value()),
    pepper,
    decoySecret: createHmac('sha256', pepper).update('decoy').digest('hex'),
    now: () => Date.now(),
    newId: () => randomBytes(16).toString('hex'),
    newCode: generateCode,
  };
}

/** Cloud Run appends the real peer address last; earlier entries are client-controlled. */
function clientIp(req: CallableRequest): string {
  const xff = req.rawRequest.headers['x-forwarded-for'];
  const raw = Array.isArray(xff) ? xff.join(',') : (xff ?? '');
  const last = raw.split(',').pop()?.trim();
  return last || req.rawRequest.ip || 'unknown';
}

function handle<I, O>(fn: (d: Deps, data: I, ip: string) => Promise<O>) {
  return onCall(options, async (req: CallableRequest<I>): Promise<O> => {
    if (ENFORCE_APP_CHECK.value() && !req.app) {
      throw new HttpsError('failed-precondition', 'app-check-required');
    }
    try {
      return await fn(deps(), (req.data ?? {}) as I, clientIp(req));
    } catch (e) {
      if (e instanceof AppError) throw new HttpsError(e.code, e.message);
      logger.error('auth function failed', e);
      throw new HttpsError('internal', 'internal');
    }
  });
}

export const authRequestOtp = handle(requestOtp);
export const authCompleteSignup = handle(completeSignup);
export const authResetPassword = handle(resetPassword);
export const authLookupLoginEmail = handle(lookupLoginEmail);
export const authCheckAvailability = handle(checkAvailability);

/** Daily cleanup of spent challenges and stale rate-limit counters. */
export const authPurgeExpired = onSchedule({ region: 'us-central1', schedule: 'every 24 hours' }, async () => {
  const cutoff = Date.now() - 24 * 3_600_000;
  for (const [col, field] of [['otp_challenges', 'expiresAt'], ['rate_limits', 'windowStart']] as const) {
    const snap = await db.collection(col).where(field, '<', cutoff).limit(500).get();
    const batch = db.batch();
    snap.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();
  }
});
