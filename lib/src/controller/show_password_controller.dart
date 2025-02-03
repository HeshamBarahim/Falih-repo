import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowPasswordController extends GetxController {
  bool obText = true;
  bool obText2 = true;

  void showPasswordFunction() {
    obText = !obText;
    update();
  }
  void showPasswordFunction_2() {
    obText2 = !obText2;
    update();
  }
}
