import { Firestore } from 'firebase-admin/firestore';
import { KeyedStore } from './types';

/** KeyedStore backed by one Firestore collection; each mutate is a transaction (fn must be pure). */
export class FirestoreStore<T extends object> implements KeyedStore<T> {
  constructor(
    private readonly db: Firestore,
    private readonly collection: string,
  ) {}

  mutate<R>(key: string, fn: (current: T | undefined) => { next?: T; result: R }): Promise<R> {
    const ref = this.db.collection(this.collection).doc(key);
    return this.db.runTransaction(async (tx) => {
      const snap = await tx.get(ref);
      const { next, result } = fn(snap.exists ? (snap.data() as T) : undefined);
      if (next !== undefined) tx.set(ref, next);
      return result;
    });
  }
}
