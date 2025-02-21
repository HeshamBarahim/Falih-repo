import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../screens/Auth/otp/otp_verification.dart';
import 'loading_dialog_controller.dart';
import 'otp_controller.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  RxBool phoneNumberError = false.obs;
  RxString phoneNumberErrorMessage = S.current.phone_number_not_exists.obs;

  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  void checkPhoneNumber() async {
    if (forgetPasswordFormKey.currentState!.validate()) {
      try {
        loadingDialogController.showLoadingDialog(Get.context!);

        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('Phone', isEqualTo: phoneNumber.text.trim())
                .limit(1)
                .get();

        loadingDialogController.closeLoadingDialog(Get.context!);

        if (querySnapshot.docs.isEmpty) {
          phoneNumberError.value = true;
        } else {
          phoneNumberError.value = false;

          final otpController = Get.put(OtpController());
          otpController.phoneNo.value = phoneNumber.text.trim();
          otpController.determineControllerType(2);
          otpController.sendOTP();

          Get.to(() => OTPVerification());
        }
      } catch (e) {
        // Handle other exceptions (e.g., invalid data format)
        throw const FormatException('Invalid Phone Number or data format');
      }
    }
  }
}
