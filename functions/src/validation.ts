export type ErrorCode =
  | 'invalid-argument'
  | 'already-exists'
  | 'resource-exhausted'
  | 'failed-precondition'
  | 'permission-denied'
  | 'unavailable'
  | 'not-found';

/** Domain error; index.ts maps it to an HttpsError with the same code. */
export class AppError extends Error {
  constructor(
    readonly code: ErrorCode,
    message: string,
  ) {
    super(message);
  }
}

export interface Profile {
  fullName: string;
  userName: string;
  schoolName: string;
  governorate?: string;
  grade?: string;
  department?: string;
  gender?: string;
}

const PHONE = /^\d{9}$/;
export const MIN_PASSWORD = 6;

export function normalizePhone(input: unknown): string | null {
  if (typeof input !== 'string') return null;
  const p = input.trim();
  return PHONE.test(p) ? p : null;
}

export function validatePassword(pw: unknown): string {
  if (typeof pw !== 'string' || pw.length < MIN_PASSWORD || pw.length > 128) {
    throw new AppError('invalid-argument', 'weak-password');
  }
  return pw;
}

function str(raw: Record<string, unknown>, key: string, required: boolean, max = 100): string | undefined {
  const v = raw[key];
  if (v === undefined || v === null || v === '') {
    if (required) throw new AppError('invalid-argument', `${key}-required`);
    return undefined;
  }
  if (typeof v !== 'string' || v.trim().length === 0 || v.length > max) {
    throw new AppError('invalid-argument', `${key}-invalid`);
  }
  return v.trim();
}

export function parseProfile(raw: unknown): Profile {
  if (typeof raw !== 'object' || raw === null) throw new AppError('invalid-argument', 'profile-required');
  const r = raw as Record<string, unknown>;
  const userName = str(r, 'userName', true, 30)!;
  if (userName.length < 3) throw new AppError('invalid-argument', 'userName-invalid');
  return {
    fullName: str(r, 'fullName', true)!,
    userName,
    schoolName: str(r, 'schoolName', true)!,
    governorate: str(r, 'governorate', false),
    grade: str(r, 'grade', false),
    department: str(r, 'department', false),
    gender: str(r, 'gender', false),
  };
}
