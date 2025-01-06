import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();

  // Observable for dark mode state
  RxBool isDarkMode = false.obs;

  // Observable for current locale
  Rx<Locale> locale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    // Load stored settings
    isDarkMode.value = _storage.read('isDarkMode') ?? false;
    locale.value = Locale(_storage.read('locale') ?? 'ar');
    Get.updateLocale(locale.value);
  }

  // Update the state
  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    _storage.write('isDarkMode', value);
  }

  // Update the app's locale
  void updateLanguage(String languageCode) {
    locale.value = Locale(languageCode);
    _storage.write('locale', languageCode);
    Get.updateLocale(locale.value);
  }
}
