import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();
  late Rx<ThemeMode> themeMode;

  // Observable for dark mode state
  RxBool isDarkMode = false.obs;
  RxBool isEnabledNotification = false.obs;

  // Observable for current locale
  Rx<Locale> locale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    // Load stored settings
    isDarkMode.value = _storage.read('isDarkMode') ?? false;
    isEnabledNotification.value =
        _storage.read('isEnabledNotification') ?? false;
    locale.value = Locale(_storage.read('locale') ?? 'ar');
    Get.updateLocale(locale.value);
    themeMode = Rx<ThemeMode>(_loadThemeFromStorage());
  }

  // Update the state
  void toggleDarkMode(bool isDark) {
    isDarkMode.value = isDark;
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    _storage.write('isDarkMode', isDark);
  }

  void toggleNotification(bool isEnabled) {
    isEnabledNotification.value = isEnabled;
    _storage.write('isEnabledNotification', isEnabled);
  }

  ThemeMode _loadThemeFromStorage() {
    bool? isDark = _storage.read<bool>('isDarkMode');
    return isDark == null
        ? ThemeMode.system
        : (isDark ? ThemeMode.dark : ThemeMode.light);
  }

  // Update the app's locale
  void updateLanguage(String languageCode) {
    locale.value = Locale(languageCode);
    _storage.write('locale', languageCode);
    Get.updateLocale(locale.value);
  }
}
