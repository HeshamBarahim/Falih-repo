import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../screens/Auth/forgot_password/change_password.dart';
import '../screens/Auth/otp/otp_verification.dart';
import 'loading_dialog_controller.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  ////////////////////////////////////////
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  final TextEditingController email = TextEditingController();

  RxBool phoneNumberError = false.obs;
  RxString phoneNumberErrorMessage = S.current.phone_number_not_exists.obs;

  checkPhoneNumber(/*Function route*/) async {
    if (forgetPasswordFormKey.currentState!.validate()) {
      // Here Check Phone Number Methode :

      try {
        loadingDialogController.showLoadingDialog(Get.context!);

        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('Phone', isEqualTo: email.text.trim())
                .limit(1)
                .get();

        loadingDialogController.closeLoadingDialog(Get.context!);

        if (querySnapshot.docs.isEmpty) {
          phoneNumberError.value = true;
        } else {
          phoneNumberError.value = false;
          // route;
          // Get.to(ChangePassword());
          Get.offAll(
              () => OTPVerification(controller: ForgetPasswordController));
        }
      } on FirebaseException catch (e) {
        // Re-throw Firestore exceptions to be handled in the main login method
        rethrow;
      } catch (e) {
        // Handle other exceptions (e.g., invalid data format)
        throw const FormatException('Invalid Phone Number or data format');
      }
    }
  }
}
