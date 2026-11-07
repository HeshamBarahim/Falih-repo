# Auth hardening: rollout guide

Nothing in this branch has been deployed. The owner deploys, in this order. Old app versions (about 10k installs) keep using the old flow until step 6, so steps 1-5 break nothing.

## What changed
- OTP creation, delivery, verification, signup, password reset and login-identifier lookup run in Cloud Functions (`functions/`): `authRequestOtp`, `authCompleteSignup`, `authResetPassword`, `authLookupLoginEmail`, `authCheckAvailability`, plus `authPurgeExpired` (daily cleanup).
- OTPs: created and checked by Smarticbot (we store no code, only phone/purpose/attempts in `otp_challenges`, no client access), 5 min TTL, 5 attempts, single use enforced by a Firestore transaction. Rate limits: 1 code/60 s and 5/hour per phone, 20/hour per IP.
- The Smarticbot key lives in Secret Manager. The client no longer knows it or any relay URL.
- Existing accounts (`<phone>@gmail.com`) keep working: the server resolves the real login email (new domain first, then legacy). New accounts use `<phone>@users.falih.invalid` (never receives mail).
- `firestore.rules` and `storage.rules` implement default-deny (audit issue 04).

## Before deploying
1. **OTP provider: Smarticbot** (`https://smarticbot.com/api/v1`, docs at smarticbot.com/en/docs). Smarticbot creates, sends and checks the code; our functions only call `send-otp` and `verify-otp` and enforce rate limits, attempt limits and single use. Connect a phone in the Smarticbot dashboard and create its API key first. Prefer the official WhatsApp Business connection over the unofficial QR one (QR sessions can be disconnected or banned, which stops every OTP).
2. Secrets (values never go in the repo or chat; run in your own terminal and paste when asked):
   ```
   firebase functions:secrets:set SMARTICBOT_API_KEY  # the key from the Smarticbot dashboard, sent as x-api-key
   firebase functions:secrets:set OTP_PEPPER          # random string (openssl rand -hex 32); keys the decoy login emails
   ```
   **Rotating the key** (the app never changes): create the new key, run `firebase functions:secrets:set SMARTICBOT_API_KEY`, `firebase deploy --only functions`, send a test OTP, then revoke the old key. Running instances read the secret at start, so the redeploy is what applies it.
   Delivery failures are logged as `otp provider error` / `otp provider unreachable` with the HTTP status and Smarticbot error code, never the key, phone or code. Alert on `otp-provider-misconfigured` (bad or revoked key).
3. Run the tests (needs Java 21 and `npm install` in `rules-tests/` and `functions/`):
   ```
   (cd functions && npm test)                 # unit tests
   (cd rules-tests && npm test)               # rules tests + adapter integration tests, in the emulators
   ```
   The emulator config (`firebase.test.json`) uses ports 18080/19099/19199 so it does not clash with other services. These tests cover the Firestore/Storage rules, the real Firestore transactions (20 concurrent verifications, exactly one wins) and the full signup, login lookup and reset flow against the Auth emulator. They do NOT cover: real Smarticbot delivery/verification (the client is tested against a fake `fetch`; its exact responses for wrong or expired codes are assumed from the docs), App Check, secrets, or the Flutter app talking to deployed functions. Test those on a staging Firebase project before production.

## Order
1. `firebase deploy --only functions` (adds endpoints; nothing calls them yet).
2. Register the app with **App Check** (Play Integrity for Android; DeviceCheck/App Attest if iOS ships). Leave `ENFORCE_APP_CHECK=false` for now.
3. Ship the new app version to Play (staged rollout). It calls the Functions and does not use the old OTP/relay/Cloud Run paths.
4. When most users are on the new version, set `ENFORCE_APP_CHECK=true` and redeploy functions.
5. Raise the minimum app version (existing force-update document in `app_config`) so old clients are forced to update. See audit issue 13: the current gate is fragile; fix before relying on it.
6. Then close the old doors, in this order:
   - Disable or delete the old Cloud Run `update-password` service (it accepts a new password with no proof, the main hole).
   - Delete the Firestore doc `app_config/whatsapp_docker` and **rotate whatever the old relay protects**: its URL has been readable by every client.
   - Firebase Console, Authentication, Settings, User actions: turn off "Enable create (sign-up)" so nobody can create accounts directly with the public API key (the Admin SDK in the Functions is unaffected).
   - `firebase deploy --only firestore:rules,storage` (these rules break old clients: username login, uniqueness checks, direct profile creation).
7. Optional: Firestore TTL policies are unnecessary; `authPurgeExpired` cleans up daily. It needs no index (single-field query).

## Known gaps
- Exam points and the single-device lock (`deviceToken`) are still client-side. The rules bound the values but do not make them trustworthy. See audit issues 12 and 13.
- Password minimum stays at 6 characters to match existing UI strings and l10n. Raising it needs new Arabic and English copy.
- Account deletion (audit issue 07) is not part of this change. `users/{uid}` deletion is denied to clients; it needs a Function.
- `usernames` is populated only for new signups; legacy usernames are found through a `users` query run by the Function. Backfill is optional and has not been written.
- `lookupLoginEmail` is rate-limited per IP and returns a decoy for unknown identifiers, so it does not reveal whether an account exists.
