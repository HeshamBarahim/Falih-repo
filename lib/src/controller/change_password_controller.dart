import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  ///////////////////////////////////
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  changePasswordFunction() {
    if (changePasswordFormKey.currentState!.validate()) {
      // Here change password Methode :
    }
  }
}
