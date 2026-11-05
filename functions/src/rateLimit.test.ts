import { describe, expect, it } from 'vitest';
import { allow } from './rateLimit';
import { Counter, MemoryStore } from './types';

const limit = { max: 3, windowMs: 1000 };

describe('allow', () => {
  it('denies the call after max within a window', async () => {
    const s = new MemoryStore<Counter>();
    const r = [];
    for (let i = 0; i < 4; i++) r.push(await allow(s, 'k', limit, 10));
    expect(r).toEqual([true, true, true, false]);
  });
  it('resets when the window rolls over', async () => {
    const s = new MemoryStore<Counter>();
    for (let i = 0; i < 4; i++) await allow(s, 'k', limit, 10);
    expect(await allow(s, 'k', limit, 1011)).toBe(true);
  });
  it('keeps keys independent', async () => {
    const s = new MemoryStore<Counter>();
    for (let i = 0; i < 4; i++) await allow(s, 'a', limit, 10);
    expect(await allow(s, 'b', limit, 10)).toBe(true);
  });
});
