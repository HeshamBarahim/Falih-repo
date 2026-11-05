import { Counter, KeyedStore } from './types';

export interface Limit {
  max: number;
  windowMs: number;
}

/** Fixed-window counter. Returns true when the call is allowed. */
export function allow(store: KeyedStore<Counter>, key: string, limit: Limit, now: number): Promise<boolean> {
  return store.mutate<boolean>(key, (c) => {
    const fresh = !c || now - c.windowStart >= limit.windowMs;
    const cur: Counter = fresh ? { count: 0, windowStart: now } : c!;
    if (cur.count >= limit.max) return { result: false };
    return { next: { ...cur, count: cur.count + 1 }, result: true };
  });
}
