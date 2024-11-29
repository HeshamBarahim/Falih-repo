import 'package:get/get.dart';

class FloatingNavBarController extends GetxController {
  int selectedIndex = 2;

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}
