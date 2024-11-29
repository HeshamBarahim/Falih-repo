import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Otp extends GetxController {
  static Otp get instance => Get.find();

  /// TextField Controllers for Phone Number and Password
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
}
