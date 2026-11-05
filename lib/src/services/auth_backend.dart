import 'package:cloud_functions/cloud_functions.dart';

/// Why an OTP is requested. `name` is the wire value the server expects.
enum OtpPurpose { signup, reset }

class OtpChallenge {
  const OtpChallenge({required this.challengeId, required this.expiresInSec});
  final String challengeId;
  final int expiresInSec;
}

class Availability {
  const Availability({this.userNameTaken, this.phoneTaken});
  final bool? userNameTaken;
  final bool? phoneTaken;
}

/// A failed call to the auth backend. [code] is the server's error code
/// (e.g. `permission-denied`), [reason] its machine-readable reason
/// (e.g. `otp-invalid`). Never contains raw exception text.
class AuthFailure implements Exception {
  AuthFailure(this.code, [this.reason = '']);
  final String code;
  final String reason;

  @override
  String toString() => 'AuthFailure($code, $reason)';
}

AuthFailure mapFunctionsError(Object error) {
  if (error is AuthFailure) return error;
  if (error is FirebaseFunctionsException) {
    return AuthFailure(error.code, error.message ?? '');
  }
  return AuthFailure('internal');
}

/// Everything identity-related that must be decided by the server.
abstract class AuthBackend {
  Future<OtpChallenge> requestOtp(
      {required String phone, required OtpPurpose purpose});

  /// Verifies the code, creates the account and returns the email to sign in with.
  Future<String> completeSignup({
    required String challengeId,
    required String code,
    required String password,
    required Map<String, String?> profile,
  });

  Future<void> resetPassword({
    required String challengeId,
    required String code,
    required String newPassword,
  });

  /// Resolves a phone number or username to the Firebase Auth email.
  /// Unknown identifiers still return an address (login then fails generically).
  Future<String> lookupLoginEmail(String identifier);

  Future<Availability> checkAvailability({String? userName, String? phone});
}

class CloudAuthBackend implements AuthBackend {
  CloudAuthBackend({FirebaseFunctions? functions})
      : _functions =
            functions ?? FirebaseFunctions.instanceFor(region: 'us-central1');

  final FirebaseFunctions _functions;

  Future<Map<String, dynamic>> _call(
      String name, Map<String, dynamic> data) async {
    try {
      final result = await _functions
          .httpsCallable(name,
              options: HttpsCallableOptions(timeout: const Duration(seconds: 20)))
          .call<Object?>(data);
      return Map<String, dynamic>.from(result.data as Map);
    } catch (e) {
      throw mapFunctionsError(e);
    }
  }

  @override
  Future<OtpChallenge> requestOtp(
      {required String phone, required OtpPurpose purpose}) async {
    final r = await _call(
        'authRequestOtp', {'phone': phone, 'purpose': purpose.name});
    return OtpChallenge(
      challengeId: r['challengeId'] as String,
      expiresInSec: (r['expiresInSec'] as num).toInt(),
    );
  }

  @override
  Future<String> completeSignup({
    required String challengeId,
    required String code,
    required String password,
    required Map<String, String?> profile,
  }) async {
    final r = await _call('authCompleteSignup', {
      'challengeId': challengeId,
      'code': code,
      'password': password,
      'profile': profile,
    });
    return r['email'] as String;
  }

  @override
  Future<void> resetPassword({
    required String challengeId,
    required String code,
    required String newPassword,
  }) async {
    await _call('authResetPassword', {
      'challengeId': challengeId,
      'code': code,
      'newPassword': newPassword,
    });
  }

  @override
  Future<String> lookupLoginEmail(String identifier) async {
    final r = await _call('authLookupLoginEmail', {'identifier': identifier});
    return r['email'] as String;
  }

  @override
  Future<Availability> checkAvailability(
      {String? userName, String? phone}) async {
    final r = await _call('authCheckAvailability', {
      if (userName != null) 'userName': userName,
      if (phone != null) 'phone': phone,
    });
    return Availability(
      userNameTaken: r['userNameTaken'] as bool?,
      phoneTaken: r['phoneTaken'] as bool?,
    );
  }
}
