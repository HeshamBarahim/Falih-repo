import { Auth } from 'firebase-admin/auth';
import { FieldValue, Firestore } from 'firebase-admin/firestore';
import { Account, ACCOUNT_DOMAIN, UserDirectory } from './authService';
import { AppError, Profile } from './validation';

/** Legacy accounts keep `<phone>@gmail.com`; lookups resolve both domains. */
const LEGACY_DOMAIN = 'gmail.com';

export class FirebaseDirectory implements UserDirectory {
  constructor(
    private readonly auth: Auth,
    private readonly db: Firestore,
  ) {}

  private async byEmail(email: string): Promise<Account | null> {
    try {
      const u = await this.auth.getUserByEmail(email);
      return { uid: u.uid, email };
    } catch (e) {
      if ((e as { code?: string }).code === 'auth/user-not-found') return null;
      throw e;
    }
  }

  async findAccountByPhone(phone: string): Promise<Account | null> {
    return (await this.byEmail(`${phone}@${ACCOUNT_DOMAIN}`)) ?? (await this.byEmail(`${phone}@${LEGACY_DOMAIN}`));
  }

  async phoneExists(phone: string): Promise<boolean> {
    return (await this.findAccountByPhone(phone)) !== null;
  }

  private claim(userName: string) {
    return this.db.collection('usernames').doc(userName.toLowerCase());
  }

  async usernameExists(userName: string): Promise<boolean> {
    return (await this.usernameToPhone(userName)) !== null;
  }

  async usernameToPhone(userName: string): Promise<string | null> {
    const claim = await this.claim(userName).get();
    if (claim.exists) return (claim.get('phone') as string) ?? null;
    // Legacy accounts predate the `usernames` collection.
    const legacy = await this.db.collection('users').where('UserName', '==', userName).limit(1).get();
    return legacy.empty ? null : ((legacy.docs[0].get('Phone') as string) ?? null);
  }

  async createAccount(a: { phone: string; password: string; profile: Profile }): Promise<Account> {
    const { phone, password, profile } = a;
    const email = `${phone}@${ACCOUNT_DOMAIN}`;
    const claimRef = this.claim(profile.userName);

    await this.db.runTransaction(async (tx) => {
      if ((await tx.get(claimRef)).exists) throw new AppError('already-exists', 'username-taken');
      tx.set(claimRef, { phone, createdAt: FieldValue.serverTimestamp() });
    });

    let uid: string;
    try {
      uid = (await this.auth.createUser({ email, password, emailVerified: false })).uid;
    } catch (e) {
      await claimRef.delete();
      if ((e as { code?: string }).code === 'auth/email-already-exists') throw new AppError('already-exists', 'phone-taken');
      throw e;
    }

    try {
      await this.db.collection('users').doc(uid).set({
        FullName: profile.fullName,
        UserName: profile.userName,
        Phone: phone,
        fakeEmail: email,
        IsVerified: 'true',
        'School Name': profile.schoolName,
        Governoroate: profile.governorate ?? null,
        Grade: profile.grade ?? null,
        Department: profile.department ?? null,
        Gender: profile.gender ?? null,
        userProfileImgUrl: '',
        createdAt: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Do not leave an Auth user without a profile document.
      await this.auth.deleteUser(uid);
      await claimRef.delete();
      throw e;
    }
    return { uid, email };
  }

  async setPassword(uid: string, password: string): Promise<void> {
    await this.auth.updateUser(uid, { password });
    await this.auth.revokeRefreshTokens(uid);
  }
}
