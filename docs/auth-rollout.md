# Auth hardening: rollout guide

Nothing in this branch has been deployed. The owner deploys, in this order. Old app versions (about 10k installs) keep using the old flow until step 6, so steps 1-5 break nothing.

## What changed
- OTP creation, delivery, verification, signup, password reset and login-identifier lookup run in Cloud Functions (`functions/`): `authRequestOtp`, `authCompleteSignup`, `authResetPassword`, `authLookupLoginEmail`, `authCheckAvailability`, plus `authPurgeExpired` (daily cleanup).
- OTPs: CSPRNG, stored only as HMAC hashes in `otp_challenges` (no client access), 5 min TTL, 5 attempts, single use. Rate limits: 1 code/60 s and 5/hour per phone, 20/hour per IP.
- The WhatsApp relay URL and key live in Secret Manager. The client no longer knows them.
- Existing accounts (`<phone>@gmail.com`) keep working: the server resolves the real login email (new domain first, then legacy). New accounts use `<phone>@users.falih.invalid` (never receives mail).
- `firestore.rules` and `storage.rules` implement default-deny (audit issue 04).

## Before deploying
1. **Relay must be reachable over HTTPS.** `WhatsAppSender` refuses `http://`. If the relay is a plain-HTTP raw-IP service, put TLS in front of it (reverse proxy) or the OTPs travel in cleartext. Ideally also add an API key check on the relay.
2. Secrets (values never go in the repo or chat):
   ```
   firebase functions:secrets:set OTP_PEPPER          # long random string, e.g. openssl rand -hex 32
   firebase functions:secrets:set WHATSAPP_API_URL    # https://... relay endpoint
   firebase functions:secrets:set WHATSAPP_API_KEY    # sent as X-Api-Key; adjust whatsapp.ts if the relay uses another header
   ```
3. Run the tests (needs Java 21 and `npm install` in `rules-tests/` and `functions/`):
   ```
   (cd functions && npm test)                 # 47 unit tests
   (cd rules-tests && npm test)               # 44 rules tests + 8 adapter integration tests, in the emulators
   ```
   The emulator config (`firebase.test.json`) uses ports 18080/19099/19199 so it does not clash with other services. These tests cover the Firestore/Storage rules, the real Firestore transactions (20 concurrent verifications, exactly one wins) and the full signup, login lookup and reset flow against the Auth emulator. They do NOT cover: WhatsApp delivery, App Check, secrets, or the Flutter app talking to deployed functions. Test those on a staging Firebase project before production.

## Order
1. `firebase deploy --only functions` (adds endpoints; nothing calls them yet).
2. Register the app with **App Check** (Play Integrity for Android; DeviceCheck/App Attest if iOS ships). Leave `ENFORCE_APP_CHECK=false` for now.
3. Ship the new app version to Play (staged rollout). It calls the Functions and does not use the old OTP/relay/Cloud Run paths.
4. When most users are on the new version, set `ENFORCE_APP_CHECK=true` and redeploy functions.
5. Raise the minimum app version (existing force-update document in `app_config`) so old clients are forced to update. See audit issue 13: the current gate is fragile; fix before relying on it.
6. Then close the old doors, in this order:
   - Disable or delete the old Cloud Run `update-password` service (it accepts a new password with no proof, the main hole).
   - Delete the Firestore doc `app_config/whatsapp_docker` and **rotate whatever the relay protects**: its URL has been readable by every client.
   - Firebase Console, Authentication, Settings, User actions: turn off "Enable create (sign-up)" so nobody can create accounts directly with the public API key (the Admin SDK in the Functions is unaffected).
   - `firebase deploy --only firestore:rules,storage` (these rules break old clients: username login, uniqueness checks, direct profile creation).
7. Optional: Firestore TTL policies are unnecessary; `authPurgeExpired` cleans up daily. It needs no index (single-field query).

## Known gaps
- Exam points and the single-device lock (`deviceToken`) are still client-side. The rules bound the values but do not make them trustworthy. See audit issues 12 and 13.
- Password minimum stays at 6 characters to match existing UI strings and l10n. Raising it needs new Arabic and English copy.
- Account deletion (audit issue 07) is not part of this change. `users/{uid}` deletion is denied to clients; it needs a Function.
- `usernames` is populated only for new signups; legacy usernames are found through a `users` query run by the Function. Backfill is optional and has not been written.
- `lookupLoginEmail` is rate-limited per IP and returns a decoy for unknown identifiers, so it does not reveal whether an account exists.
