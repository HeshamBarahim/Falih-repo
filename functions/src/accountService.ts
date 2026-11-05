import { AppError } from './validation';

export const RECENT_LOGIN_MS = 5 * 60_000;

export interface AccountData {
  /** Removes everything stored for the user: profile, history, notifications, username claim, profile image. Must be idempotent. */
  deleteUserData(uid: string): Promise<void>;
  deleteAuthUser(uid: string): Promise<void>;
}

export interface DeleteDeps {
  data: AccountData;
  now(): number;
}

/**
 * Deletes the calling user's account. Requires a login within the last five
 * minutes (the app re-authenticates first). Data goes before the Auth user, so
 * a failure part-way leaves a user who can simply try again.
 */
export async function deleteAccount(
  d: DeleteDeps,
  caller: { uid?: string; authTimeSec?: number },
): Promise<Record<string, never>> {
  if (!caller.uid) throw new AppError('permission-denied', 'sign-in-required');
  const authTimeMs = (caller.authTimeSec ?? 0) * 1000;
  if (d.now() - authTimeMs > RECENT_LOGIN_MS) {
    throw new AppError('failed-precondition', 'recent-login-required');
  }
  await d.data.deleteUserData(caller.uid);
  await d.data.deleteAuthUser(caller.uid);
  return {};
}
