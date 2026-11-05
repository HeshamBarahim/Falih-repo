import { describe, expect, it } from 'vitest';
import { AppError, normalizePhone, parseProfile, validatePassword } from './validation';

describe('normalizePhone', () => {
  it('accepts nine digits and trims spaces', () => {
    expect(normalizePhone('771234567')).toBe('771234567');
    expect(normalizePhone('  771234567 ')).toBe('771234567');
  });
  it.each(['+967771234567', '77123456', '7712345678', 'abc123456', '', null, 42])(
    'rejects %s',
    (v) => expect(normalizePhone(v as unknown as string)).toBeNull(),
  );
});

describe('validatePassword', () => {
  it('returns a valid password unchanged (no trimming)', () => {
    expect(validatePassword(' abc123 ')).toBe(' abc123 ');
  });
  it('rejects short or non-string passwords', () => {
    expect(() => validatePassword('12345')).toThrow(AppError);
    expect(() => validatePassword(undefined)).toThrow(AppError);
  });
});

describe('parseProfile', () => {
  const ok = { fullName: ' Ali ', userName: 'ali_1', schoolName: 'S' };
  it('trims and keeps optional fields', () => {
    const p = parseProfile({ ...ok, grade: '9' });
    expect(p.fullName).toBe('Ali');
    expect(p.grade).toBe('9');
  });
  it('requires fullName, userName, schoolName', () => {
    expect(() => parseProfile({ userName: 'x1y', schoolName: 'S' })).toThrow(AppError);
    expect(() => parseProfile(null)).toThrow(AppError);
  });
  it('rejects too-short or too-long usernames', () => {
    expect(() => parseProfile({ ...ok, userName: 'ab' })).toThrow(AppError);
    expect(() => parseProfile({ ...ok, userName: 'a'.repeat(31) })).toThrow(AppError);
  });
});
