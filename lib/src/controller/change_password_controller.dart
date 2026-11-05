import 'package:falih/src/constants/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../services/auth_backend.dart';
import '../services/auth_messages.dart';
import 'loading_dialog_controller.dart';
import 'otp_controller.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordController({AuthBackend? backend})
      : _backend = backend ?? CloudAuthBackend();

  final AuthBackend _backend;

  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final otpController = Get.find<OtpController>();
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  /// Sends the code the user typed plus the new password. The server verifies
  /// the code and changes the password in one step.
  Future<void> changePasswordFunction() async {
    if (!changePasswordFormKey.currentState!.validate()) return;
    final challengeId = otpController.challengeId;
    final code = otpController.enteredCode;
    if (challengeId == null || code == null) {
      Get.offAllNamed("forgot-password");
      return;
    }

    loadingDialogController.showLoadingDialog();
    try {
      await _backend.resetPassword(
        challengeId: challengeId,
        code: code,
        newPassword: password.text.trim(),
      );
      loadingDialogController.closeLoadingDialog();
      showSuccessMessage(message: "Password updated successfully!"); // TODO(l10n)
      Get.offAllNamed("login");
    } on AuthFailure catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(authErrorMessage(e));
      // A wrong, expired or used-up code cannot be retried here: start over.
      if (e.code == 'permission-denied' || e.code == 'failed-precondition') {
        Get.offAllNamed("forgot-password");
      }
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(S.current.unexpected_error_occured);
    }
  }
}
