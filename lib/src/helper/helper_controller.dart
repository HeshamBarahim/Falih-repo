import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper extends GetxController {
  /* -- ============= VALIDATIONS ================ -- */

  static String? validatePhoneNumber(value) {
    if (value == null || value.isEmpty) return "Phone Numbers cannot be empty";

    String pattern = r'^\d{9}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Phone numbers must be valid';
    }
    return null;
  }

  static String? validatePassword(value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';

    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be 6 characters at least';
    }
    return null;
  }

  static String? validateSchoolName(value) {
    if (value == null || value.isEmpty) return "School Name cannot be empty";

    String pattern = r"^[a-zA-Z\s.'-]{2,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'School Name must be valid';
    }
    return null;
  }

  static String? validatefullName(value) {
    if (value == null || value.isEmpty) return "Name cannot be empty";

    String pattern = r"^[a-zA-Z\s.'-]{2,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'User Name must be valid';
    }
    return null;
  }

  /* -- ============= SNACK-BARS ================ -- */

  static successSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(10),
    );
  }

  static warningSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(10),
    );
  }

  static errorSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(10),
    );
  }

  static modernSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      colorText: Colors.white,
      backgroundColor: Colors.blueGrey,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(10),
    );
  }
}
