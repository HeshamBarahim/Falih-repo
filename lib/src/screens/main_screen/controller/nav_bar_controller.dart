import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavBarController extends GetxController {
  bool isProsess = false;

  void startProsess(int index) {
    isProsess = true;
    update();
  }

  void stoptProsess(int index) {
    isProsess = false;
    update();
  }
}
