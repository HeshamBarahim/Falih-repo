import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper extends GetxController {
  /* -- ============= VALIDATIONS ================ -- */

  static String? validatePhoneNumber(value) {
    if (value == null || value.isEmpty) return S.current.phone_cant_be_empty;

    if (int.tryParse(value) != null) {
      String pattern = r'^\d{9}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value.trim())) {
        return 'Phone numbers must be valid';
      }
    }
    return null;
  }

  //   static String? validatePhoneNumber(
  //     value, QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  //   if (value == null || value.isEmpty) return S.current.phone_cant_be_empty;

  //   if (int.tryParse(value) != null) {
  //     String pattern = r'^\d{9}$';
  //     RegExp regex = RegExp(pattern);
  //     if (!regex.hasMatch(value)) {
  //       return 'Phone numbers must be valid';
  //     }
  //   } else if (querySnapshot.docs.isEmpty) {
  //     return 'UserName is Not Correct';
  //   } //else {
  //   //   return 'User numbers must be valid';
  //   // }

  //   return null;
  // }

  static String? validatePassword(value) {
    if (value == null || value.isEmpty) return S.current.passwrod_cant_be_empty;

    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return S.current.passwrod_must_be;
    }
    return null;
  }

  static String? validateSchoolName(value) {
    if (value == null || value.isEmpty) return S.current.school_cant_be_empty;

    String pattern = r"^[a-zA-Z\u0600-\u06FF\s.'-]{2,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return S.current.school_must_be;
    }
    return null;
  }

  static String? validatefullName(value) {
    if (value == null || value.isEmpty) return S.current.name_cant_be_empty;

    String pattern = r"^[a-zA-Z\u0600-\u06FF\s.'-]{2,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return S.current.name_must_be;
    }
    return null;
  }

  static String? validateUsername(value) {
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (value.isEmpty) {
      return S.current.username_cant_be_empty;
    } else if (value.length <= 3) {
      return S.current.username_too_short;
    } else if (!usernameRegExp.hasMatch(value)) {
      return S.current.username_invalid_chars;
    } else if (value.contains(' ')) {
      return S.current.username_no_spaces;
    } else {
      return null;
    }
  }

  static String? validateGovernorate(value) {
    if (value == null || value.isEmpty) {
      return S.current.u_should_choose_governorate;
    }
    return null;
  }

  static String? validateGrade(value) {
    if (value == null || value.isEmpty) {
      return S.current.u_should_choose_grade;
    }
    return null;
  }

  static String? validateDepartment(value) {
    if (value == null || value.isEmpty) {
      return S.current.u_should_choose_department;
    }
    return null;
  }

  static String? validateGender(value) {
    if (value == null || value.isEmpty) {
      return S.current.u_should_choose_gender;
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
      dismissDirection: DismissDirection.horizontal,
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
      dismissDirection: DismissDirection.horizontal,
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
      dismissDirection: DismissDirection.horizontal,
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
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.blueGrey,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(10),
    );
  }
}
