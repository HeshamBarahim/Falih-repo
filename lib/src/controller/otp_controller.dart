import 'dart:async';

import 'package:falih/generated/l10n.dart';
import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_backend.dart';
import '../services/auth_messages.dart';

/// Holds the state of one OTP challenge. The code is created, delivered and
/// checked by the server; this controller only requests it and relays what the
/// user typed.
class OtpController extends GetxController {
  OtpController({AuthBackend? backend}) : _backend = backend ?? CloudAuthBackend();

  final AuthBackend _backend;

  final otpTextController = TextEditingController();
  final phoneNo = "".obs;
  final resendTimeout = 60.obs; // seconds until a resend is allowed
  final canResendOtp = true.obs;
  final isSending = false.obs;
  final RxInt controllerType = 1.obs; // 1 = signup, 2 = password reset

  /// Server-issued id of the active challenge.
  String? challengeId;

  /// Code the user typed for a password reset; it is checked by the server
  /// together with the new password (a code is single use).
  String? enteredCode;

  /// Why the last [sendOtp] failed, if it did.
  AuthFailure? lastFailure;

  Timer? _resendTimer;

  @override
  void onClose() {
    _resendTimer?.cancel();
    otpTextController.dispose();
    super.onClose();
  }

  void determineControllerType(int type) {
    controllerType.value = type;
  }

  Future<bool> sendOtp() async {
    isSending.value = true;
    lastFailure = null;
    try {
      final challenge = await _backend.requestOtp(
        phone: phoneNo.value,
        purpose: controllerType.value == 1 ? OtpPurpose.signup : OtpPurpose.reset,
      );
      challengeId = challenge.challengeId;
      enteredCode = null;
      startResendTimer();
      return true;
    } on AuthFailure catch (e) {
      lastFailure = e;
      return false;
    } finally {
      isSending.value = false;
    }
  }

  void startResendTimer() {
    _resendTimer?.cancel();
    canResendOtp.value = false;
    resendTimeout.value = 60;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimeout.value > 0) {
        resendTimeout.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    if (!canResendOtp.value) return;
    if (!await sendOtp()) showErrorMessage(authErrorMessage(lastFailure));
  }

  /// Called when the user has typed all digits.
  Future<void> verifyOtp(String code) async {
    final id = challengeId;
    if (id == null) {
      showErrorMessage(S.current.invalid_ver_code);
      return;
    }
    if (controllerType.value == 1) {
      await Get.find<SignUpController>().completeSignup(id, code);
    } else {
      enteredCode = code;
      Get.offAllNamed("change-password");
    }
  }
}
