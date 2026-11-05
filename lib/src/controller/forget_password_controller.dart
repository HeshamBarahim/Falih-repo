import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../constants/dialogs.dart';
import '../services/auth_messages.dart';
import 'loading_dialog_controller.dart';
import 'otp_controller.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  RxBool phoneNumberError = false.obs;
  RxString phoneNumberErrorMessage = S.current.phone_number_not_exists.obs;

  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  /// Asks the server to send a reset code. The server answers the same way
  /// whether or not the number is registered, so this screen cannot be used
  /// to find out who has an account.
  Future<void> checkPhoneNumber() async {
    if (!forgetPasswordFormKey.currentState!.validate()) return;
    loadingDialogController.showLoadingDialog();
    try {
      final otpController = Get.put(OtpController());
      otpController.phoneNo.value = phoneNumber.text.trim();
      otpController.determineControllerType(2);
      if (await otpController.sendOtp()) {
        // Replaces the loading dialog route and shows the OTP page.
        Get.offNamed("otp-verification");
      } else {
        loadingDialogController.closeLoadingDialog();
        showErrorMessage(authErrorMessage(otpController.lastFailure));
      }
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(S.current.unexpected_error_occured);
    }
  }
}
