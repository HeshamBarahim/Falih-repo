import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoicesController extends GetxController {
  // -1 means none selected initially
  var selectedIndex = (-1).obs;

  // Method to change the selected index
  void selectChoice(int index) {
    selectedIndex.value = index;
  }

  // Get the color based on whether the choice is selected
  Color getChoiceColor(int index) {
    return selectedIndex.value == index
        ? AppColors.mainColor
        : AppColors.choicesColor;
  }
}
