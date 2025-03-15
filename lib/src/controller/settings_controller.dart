import 'package:firebase_messaging/firebase_messaging.dart';
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
  Future<void> toggleDarkMode(bool isDark) async {
    isDarkMode.value = isDark;
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    await _storage.write('isDarkMode', isDark);

    if (isDark) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  void toggleNotification(bool isEnabled) {
    isEnabledNotification.value = isEnabled;
    _storage.write('isEnabledNotification', isEnabled);

    if (isEnabled) {
      // Request notification permissions if not granted
      FirebaseMessaging.instance.requestPermission();
    } else {
      // Optionally, remove the device's FCM token to stop notifications
      FirebaseMessaging.instance.deleteToken();
    }
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
