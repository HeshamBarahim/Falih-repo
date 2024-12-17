import 'dart:ui';

import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Observable for dark mode state
  RxBool isDarkMode = false.obs;

  // Observable for current locale
  Rx<Locale> locale = const Locale('en').obs;

  // Update the state
  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  // Update the app's locale dynamically
  void updateLanguage(String languageCode) {
    locale.value = Locale(languageCode);
    Get.updateLocale(locale.value);
  }
}
