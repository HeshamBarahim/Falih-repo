import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../repository/authentication_repository/authentication_repository.dart';
import 'loading_dialog_controller.dart';

class OtpController extends GetxController {
  final otpTextController = TextEditingController();
  var phoneNo = "".obs;
  var resendTimeout = 60.obs; // Resend timeout in seconds
  var canResendOtp = false.obs; // Whether the user can resend OTP
  var generatedOtp = ''.obs; // Dynamically generated OTP
  var isSending = false.obs; // Loading state
  final RxInt controllerType = 1.obs;
  Timer? _resendTimer;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  @override
  void onClose() {
    _resendTimer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }

  // Determine The Type of Controller
  determineControllerType(int type) {
    controllerType.value = type;
  }

  // Simulate sending OTP via API
  Future<bool> sendOtpToWhatsApp() async {
    startResendTimer();
    isSending.value = true;

    final random = Random();
    generatedOtp.value = (100000 + random.nextInt(900000)).toString();

    final snapshot =
        await _firestore.collection('app_config').doc("whatsapp_docker").get();

    final otpServer = snapshot.data();
    var otpAPI = otpServer!["api_url"];

    try {
      final response = await http
          .post(
        Uri.parse(otpAPI),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "chatId": "967${phoneNo.value}",
          "reply_to": null,
          "text": """عزيزي العميل،
رمز التحقق الخاص بك لتطبيق فالح هو ${generatedOtp.value}. يرجى عدم مشاركته مع أي شخص.
يظل الرمز صالحًا لمدة 5 دقائق.

شكرًا لاستخدامك تطبيق فالح! 🚀""",
          "linkPreview": true,
          "session": "default"
        }),
      )
          .timeout(
        const Duration(seconds: 20), // Set timeout duration
        onTimeout: () {
          throw TimeoutException("Request to server timed out!");
        },
      );
      if (response.statusCode == 201) {
        isSending.value = false;
        return true;
      } else {
        return false;
        // Get.back();
        // showErrorMessage(S.current.failed_send_ver_code);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isSending.value = false;
    }
    return false;
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
      startResendTimer();
      sendOtpToWhatsApp();
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String enteredOtp) async {
    if (enteredOtp == generatedOtp.value) {
      showSuccessMessage(message: S.current.code_verified_successfully);
      loadingDialogController.showLoadingDialog();

      if (controllerType.value == 1) {
        final SignUpController signUpController = Get.put(SignUpController());
        await signUpController.addUser();

        final auth = AuthenticationRepository.instance;
        await auth.setInitialScreen();
        loadingDialogController.closeLoadingDialog();

        Get.offAllNamed("main-screen");
      } else if (controllerType.value == 2) {
        loadingDialogController.closeLoadingDialog();
        Get.offAllNamed("change-password");
      }
    } else {
      showErrorMessage(S.current.invalid_ver_code);
    }
  }
}
