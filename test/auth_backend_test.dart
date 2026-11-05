import 'package:cloud_functions/cloud_functions.dart';
import 'package:falih/src/services/auth_backend.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mapFunctionsError', () {
    test('keeps the server code and reason', () {
      final f = mapFunctionsError(
          FirebaseFunctionsException(code: 'permission-denied', message: 'otp-invalid'));
      expect(f.code, 'permission-denied');
      expect(f.reason, 'otp-invalid');
    });

    test('maps an unreachable server to unavailable without a reason', () {
      final f = mapFunctionsError(
          FirebaseFunctionsException(code: 'unavailable', message: 'UNAVAILABLE'));
      expect(f.code, 'unavailable');
    });

    test('maps unknown exceptions to internal and hides their text', () {
      final f = mapFunctionsError(Exception('socket secret detail'));
      expect(f.code, 'internal');
      expect(f.toString(), isNot(contains('secret')));
    });
  });

  group('OtpPurpose', () {
    test('uses the wire names the server expects', () {
      expect(OtpPurpose.signup.name, 'signup');
      expect(OtpPurpose.reset.name, 'reset');
    });
  });
}
