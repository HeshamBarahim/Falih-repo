import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../repository/authentication_repository/authentication_repository.dart';

class OtpController extends GetxController {
  final otpTextController = TextEditingController();
  var resendTimeout = 60.obs; // Resend timeout in seconds
  var canResendOtp = false.obs; // Whether the user can resend OTP
  var generatedOtp = ''.obs; // Dynamically generated OTP
  Timer? _resendTimer;
  var isSending = false.obs; // Loading state
  final signupController =
      Get.find<SignUpController>(); // Initialize the controller

  @override
  void onInit() {
    super.onInit();
    generateAndSendOtp();
    startResendTimer();
  }

  @override
  void onClose() {
    _resendTimer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }

  // Generate a random 6-digit OTP
  void generateAndSendOtp() {
    isSending.value = true;

    final random = Random();
    generatedOtp.value = (100000 + random.nextInt(900000)).toString();
    print('Generated OTP: ${generatedOtp.value}'); // For debugging
    // Call your API to send the OTP here
    sendOtpToWhatsApp(generatedOtp.value);
  }

  // Simulate sending OTP via API
  Future<void> sendOtpToWhatsApp(String otp) async {
    // Replace with your API call
    print('Sending OTP to WhatsApp: $otp');

    try {
      final response = await http.post(
        Uri.parse('http://3.145.168.89:3000/api/sendText'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "chatId": "967${signupController.phoneNo.text}",
          "reply_to": null,
          "text": """عزيزي العميل،
رمز التحقق الخاص بك لتطبيق فالح هو $otp. يرجى عدم مشاركته مع أي شخص.
يظل الرمز صالحًا لمدة 5 دقائق.

شكرًا لاستخدامك تطبيق فالح! 🚀""",
          "linkPreview": true,
          "session": "default"
        }),
      );

      if (response.statusCode == 201) {
        isSending.value = false;
      } else {
        showErrorMessage('Failed to send OTP. Please try again.');
      }
    } catch (e) {
      showErrorMessage('Failed to send OTP. Please try again.');
    } finally {
      isSending.value = false;
    }
  }

  // Start the resend timer
  void startResendTimer() {
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

  // Resend OTP
  void resendOtp() {
    if (canResendOtp.value) {
      generateAndSendOtp();
      startResendTimer();
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String enteredOtp) async {
    if (enteredOtp == generatedOtp.value) {
      showSuccessMessage(message: "OTP verified successfully.");
      final auth = AuthenticationRepository.instance;
      await auth.setInitialScreen(auth.firebaseUser);
      Get.offAll(() => const MainScreen());
    } else {
      showErrorMessage('Invalid OTP. Please try again.');
    }
  }
}
