export type Purpose = 'signup' | 'reset';

export interface Challenge {
  phone: string;
  purpose: Purpose;
  createdAt: number;
  expiresAt: number;
  attempts: number;
  consumed: boolean;
}

export interface Counter {
  count: number;
  windowStart: number;
}

/** Atomic read-modify-write on one keyed document. */
export interface KeyedStore<T> {
  mutate<R>(
    key: string,
    fn: (current: T | undefined) => { next?: T; result: R },
  ): Promise<R>;
}

export class MemoryStore<T> implements KeyedStore<T> {
  readonly data = new Map<string, T>();
  async mutate<R>(
    key: string,
    fn: (current: T | undefined) => { next?: T; result: R },
  ): Promise<R> {
    const { next, result } = fn(this.data.get(key));
    if (next !== undefined) this.data.set(key, next);
    return result;
  }
}
