# Auth Hardening Implementation Plan

> **For agentic workers:** Use superpowers:executing-plans (native) task-by-task. Steps use checkbox syntax.

**Goal:** Move OTP generation/verification, signup, password reset and login-identifier lookup from the client (and an unauthenticated Cloud Run endpoint) into server-side Firebase Cloud Functions, then make the app a thin client of them. Fixes audit issues 01, 02, 03, 05, 09, 10 (client part). Rules for issue 04 are delivered as files.

**Architecture:** Callable Cloud Functions (2nd gen, TypeScript, `functions/`) with all logic in a dependency-injected service layer (`authService.ts`) so it is unit-testable with in-memory stores. OTPs are CSPRNG, stored only as HMAC hashes in admin-only Firestore, 5 min TTL, 5 attempts, single use, rate-limited per phone and IP. The client never sees the relay URL or builds login emails. Flutter side talks to a small `AuthBackend` interface (GetX controllers stay).

**Tech Stack:** Firebase Functions v2 + firebase-admin (Node 22), vitest, Flutter/GetX, `cloud_functions`, `firebase_app_check`.

## Global Constraints
- No deploy, no push, no live-service calls. Everything is files plus local tests.
- ~10k live accounts use `<9-digit phone>@gmail.com` as the Firebase Auth email. They MUST keep logging in with no migration: the server resolves the email (new domain first, legacy second).
- Phone format stays `^\d{9}$`; WhatsApp chatId stays `967<phone>`. Password min length stays 6 (matches UI strings).
- Firestore user doc keys stay as-is (`FullName`, `UserName`, `Phone`, `fakeEmail`, `IsVerified`, `School Name`, `Governoroate`, `Grade`, `Department`, `Gender`, `userProfileImgUrl`, `deviceToken`): other unseen backend jobs may read them.
- Secrets (`WHATSAPP_API_URL`, `WHATSAPP_API_KEY`, `OTP_PEPPER`) via Secret Manager params, never in the repo.
- Callables: region `us-central1`, App Check enforcement behind boolean param `ENFORCE_APP_CHECK` (default false until Play Integrity is registered).
- Rules tightening breaks old app versions: rules deploy LAST (see rollout doc).

## Review Focus
- Same OTP verified twice concurrently: only one succeeds (single-use inside one transaction).
- Wrong code 5 times then the right code: locked.
- Reset for an unregistered phone: same response shape as registered (no enumeration), no message sent.
- Unknown username at login lookup: returns a decoy email, not an error.
- Challenge for `signup` used to reset (purpose mismatch): rejected.

---

### Task 1: Functions scaffold
**Files:** Create `functions/package.json`, `functions/tsconfig.json`, `functions/vitest.config.ts`, `functions/.gitignore`.
- [ ] `npm install` succeeds; `npx tsc --noEmit` and `npx vitest run` run (no tests yet).

### Task 2: Phone + validation (`functions/src/validation.ts`)
**Produces:** `normalizePhone(input:string): string|null`, `parseProfile(raw:unknown): Profile`, `validatePassword(pw:unknown): string`, `AppError(code, message)`.
- [ ] Tests: 9 digits ok; spaces trimmed; `+967…`/8 digits/letters → null; profile missing `fullName` throws `invalid-argument`; password <6 throws.

### Task 3: OTP core (`functions/src/otp.ts`, `types.ts`)
**Produces:** `KeyedStore<T>.mutate`, `generateCode()`, `hashCode(pepper,id,code)`, `issueChallenge(...)`, `verifyChallenge(...) → status`.
- [ ] Tests (in-memory store): correct code ok once, second use `consumed`; wrong code increments attempts; 5 wrong → `locked` even with right code; expired; purpose mismatch; hash is not the code; code is 6 digits.

### Task 4: Rate limit (`functions/src/rateLimit.ts`)
**Produces:** `allow(store,key,{max,windowMs},now): Promise<boolean>`.
- [ ] Tests: max+1th call denied; window rollover resets; separate keys independent.

### Task 5: Auth service (`functions/src/authService.ts`)
**Produces:** `requestOtp`, `completeSignup`, `resetPassword`, `lookupLoginEmail`, `checkAvailability` taking `Deps` (stores, `UserDirectory`, `OtpSender`, `pepper`, `now`).
- [ ] Tests for each Review Focus line, plus: signup for existing phone rejected; resend within 60 s denied; sender failure → `unavailable` and challenge not usable; reset updates password and revokes tokens; signup returns email, never the code.

### Task 6: Firebase adapters + entrypoint (`firestoreStores.ts`, `directory.ts`, `whatsapp.ts`, `index.ts`)
- [ ] `npx tsc --noEmit` clean. (Adapters need the emulator to test; not available here: stated in rollout doc.)

### Task 7: Rules + config (`firestore.rules`, `storage.rules`, `firebase.json`, `docs/auth-rollout.md`)
- [ ] Files written; rollout order and legacy-client impact documented. Rules are UNTESTED (no emulator/Java on this server).

### Task 8: Flutter compiles again
- [ ] Failing: `flutter analyze` shows 2 errors. Fix `CardTheme`→`CardThemeData` in `themes.dart`, remove unused `google_fonts`. `flutter analyze` has 0 errors.

### Task 9: Flutter `AuthBackend` + controllers
**Produces:** `AuthBackend` (`requestOtp`, `completeSignup`, `resetPassword`, `lookupLoginEmail`, `checkAvailability`), `CloudAuthBackend`, `AuthFailure(code)`.
- [ ] Tests with a fake backend: OTP controller state machine (send → verify), forgot-password navigates on success (issue 09), user model round-trip (issue 10), login resolves email via backend.
- [ ] Replace client OTP generation/relay call, `URLs`, `@gmail.com` building, direct `users` queries; add App Check activation in `main.dart`.

### Task 10: Verify
- [ ] `vitest run`, `tsc --noEmit`, `flutter analyze`, `flutter test` outputs reported with any failures named.
