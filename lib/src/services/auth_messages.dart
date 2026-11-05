import '../../generated/l10n.dart';
import 'auth_backend.dart';

/// User-facing text for an auth failure, using existing l10n strings.
/// TODO(l10n): add dedicated strings for too-many-requests, otp-expired,
/// phone-taken and weak-password; they currently fall back to the generic message.
String authErrorMessage(AuthFailure? f) {
  switch (f?.reason) {
    case 'otp-invalid':
      return S.current.invalid_ver_code;
    case 'otp-send-failed':
      return S.current.failed_send_ver_code;
    case 'username-taken':
      return S.current.username_already_exists;
  }
  if (f?.code == 'unavailable') return S.current.no_internet_connection;
  return S.current.unexpected_error_occured;
}
