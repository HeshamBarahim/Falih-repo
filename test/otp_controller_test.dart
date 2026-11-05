import 'package:falih/src/controller/otp_controller.dart';
import 'package:falih/src/services/auth_backend.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fake_auth_backend.dart';

void main() {
  late FakeAuthBackend backend;
  late OtpController controller;

  setUp(() {
    backend = FakeAuthBackend();
    controller = OtpController(backend: backend);
    controller.phoneNo.value = '771234567';
  });

  tearDown(() => controller.onClose());

  test('sendOtp asks the server for a signup challenge and keeps its id', () async {
    controller.determineControllerType(1);
    expect(await controller.sendOtp(), isTrue);
    expect(backend.calls, ['requestOtp:771234567:signup']);
    expect(controller.challengeId, 'challenge-1');
    expect(controller.canResendOtp.value, isFalse);
    expect(controller.isSending.value, isFalse);
  });

  test('type 2 requests a reset challenge', () async {
    controller.determineControllerType(2);
    await controller.sendOtp();
    expect(backend.calls.single, 'requestOtp:771234567:reset');
  });

  test('a server failure returns false, records the failure, keeps no challenge', () async {
    backend.failWith = AuthFailure('unavailable', 'otp-send-failed');
    expect(await controller.sendOtp(), isFalse);
    expect(controller.lastFailure?.reason, 'otp-send-failed');
    expect(controller.challengeId, isNull);
    expect(controller.isSending.value, isFalse);
  });

  test('a failed send does not start the resend countdown', () async {
    backend.failWith = AuthFailure('resource-exhausted', 'too-many-requests');
    await controller.sendOtp();
    expect(controller.canResendOtp.value, isTrue);
  });

  test('the code is never generated on the device', () async {
    await controller.sendOtp();
    expect(controller.toString(), isNot(contains('generatedOtp')));
  });
}
