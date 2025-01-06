import 'package:get/get.dart';

class BackPressController extends GetxController {
  DateTime? lastBackPressTime;

// Check if the back press should exit the app
  bool shouldExit() {
    DateTime now = DateTime.now();
    if (lastBackPressTime == null ||
        now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
      lastBackPressTime = now;
      // Stay in the app
      return false;
    }
    // Exit the app
    return true;
  }
}
