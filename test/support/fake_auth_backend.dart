import 'package:falih/src/services/auth_backend.dart';

class FakeAuthBackend implements AuthBackend {
  final List<String> calls = [];
  AuthFailure? failWith;
  int _n = 0;

  void _maybeFail() {
    if (failWith != null) throw failWith!;
  }

  @override
  Future<OtpChallenge> requestOtp(
      {required String phone, required OtpPurpose purpose}) async {
    calls.add('requestOtp:$phone:${purpose.name}');
    _maybeFail();
    return OtpChallenge(challengeId: 'challenge-${++_n}', expiresInSec: 300);
  }

  @override
  Future<String> completeSignup({
    required String challengeId,
    required String code,
    required String password,
    required Map<String, String?> profile,
  }) async {
    calls.add('completeSignup:$challengeId:$code');
    _maybeFail();
    return '771234567@users.falih.invalid';
  }

  @override
  Future<void> resetPassword({
    required String challengeId,
    required String code,
    required String newPassword,
  }) async {
    calls.add('resetPassword:$challengeId:$code');
    _maybeFail();
  }

  @override
  Future<void> deleteAccount() async {
    calls.add('deleteAccount');
    _maybeFail();
  }

  @override
  Future<String> lookupLoginEmail(String identifier) async {
    calls.add('lookup:$identifier');
    _maybeFail();
    return 'resolved@users.falih.invalid';
  }

  @override
  Future<Availability> checkAvailability(
      {String? userName, String? phone}) async {
    calls.add('availability:$userName:$phone');
    _maybeFail();
    return const Availability(userNameTaken: false, phoneTaken: false);
  }
}
