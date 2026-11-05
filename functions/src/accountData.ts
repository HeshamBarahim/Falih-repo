import { Auth } from 'firebase-admin/auth';
import { Firestore } from 'firebase-admin/firestore';
import { AccountData } from './accountService';

export class FirebaseAccountData implements AccountData {
  constructor(
    private readonly auth: Auth,
    private readonly db: Firestore,
    /** Deletes `user_profile_images/<uid>`; must not fail when the file is absent. */
    private readonly deleteProfileImage: (uid: string) => Promise<void>,
  ) {}

  async deleteUserData(uid: string): Promise<void> {
    const userRef = this.db.collection('users').doc(uid);
    const profile = await userRef.get();
    const userName = profile.get('UserName') as string | undefined;

    // recursiveDelete also removes subcollections (notifications, userExams).
    await this.db.recursiveDelete(userRef);
    await this.db.recursiveDelete(this.db.collection('exams').doc(uid));

    if (userName) {
      const claim = this.db.collection('usernames').doc(userName.toLowerCase());
      // Only release the claim if it still belongs to this user's phone.
      const phone = profile.get('Phone') as string | undefined;
      const snap = await claim.get();
      if (snap.exists && snap.get('phone') === phone) await claim.delete();
    }
    await this.deleteProfileImage(uid);
  }

  async deleteAuthUser(uid: string): Promise<void> {
    try {
      await this.auth.deleteUser(uid);
    } catch (e) {
      if ((e as { code?: string }).code !== 'auth/user-not-found') throw e;
    }
  }
}
