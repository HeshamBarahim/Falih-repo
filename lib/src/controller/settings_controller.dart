import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Observable for dark mode state
  RxBool isDarkMode = false.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value; // Update the state
  }
}
