import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  ////////////////////////////////////////
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  checkPhoneNumber() {
    if (forgetPasswordFormKey.currentState!.validate()) {
      // Here Check Phone Number Methode :
    }
  }
}
