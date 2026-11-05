import '../../generated/l10n.dart';
import 'auth_backend.dart';

/// User-facing text for an auth failure.
String authErrorMessage(AuthFailure? f) {
  switch (f?.reason) {
    case 'otp-invalid':
      return S.current.invalid_ver_code;
    case 'otp-send-failed':
      return S.current.failed_send_ver_code;
    case 'username-taken':
      return S.current.username_already_exists;
    case 'phone-taken':
      return S.current.phone_already_registered;
    case 'weak-password':
      return S.current.weak_password;
    case 'too-many-requests':
      return S.current.too_many_requests;
    case 'otp-expired':
    case 'otp-locked':
    case 'otp-consumed':
      return S.current.otp_expired;
  }
  if (f?.code == 'resource-exhausted') return S.current.too_many_requests;
  if (f?.code == 'unavailable') return S.current.no_internet_connection;
  return S.current.unexpected_error_occured;
}
