import 'dart:async';
import 'dart:convert';

import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/constants/urls.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'loading_dialog_controller.dart';
import 'otp_controller.dart';

class ChangePasswordController extends GetxController {
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final otpController = Get.find<OtpController>();
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  void changePasswordFunction() async {
    if (changePasswordFormKey.currentState!.validate()) {
      loadingDialogController.showLoadingDialog();
      final String email = "${otpController.phoneNo.value}@gmail.com";
      final String passwordText = password.text.trim();

      if (email.isEmpty || passwordText.isEmpty) {
        showErrorMessage("Email and password cannot be empty.");
        return;
      }

      final Uri url = Uri.parse(URLs.UPDATE_PASSWORD_API);

      try {
        final response = await http
            .post(
              url,
              headers: {"Content-Type": "application/json"},
              body: jsonEncode({"email": email, "newPassword": passwordText}),
            )
            .timeout(
              const Duration(seconds: 10),
            );

        if (response.statusCode == 200) {
          showSuccessMessage(message: "Password updated successfully!");
          Get.offAll(() => Login());
        } else {
          // Parse server error messages if available
          final Map<String, dynamic>? responseData = jsonDecode(response.body);
          final String errorMessage =
              responseData?["error"] ?? "Failed to update password.";

          showErrorMessage(errorMessage);
        }
      } on TimeoutException {
        showErrorMessage("Request timed out. Please try again.");
      } on FormatException {
        showErrorMessage("Invalid response format from server.");
      } on Exception catch (e) {
        showErrorMessage("An unexpected error occurred. Please try again.");
        print("Error: $e"); // Log the error for debugging
      } finally {
        loadingDialogController.closeLoadingDialog();
      }
    }
  }
}
