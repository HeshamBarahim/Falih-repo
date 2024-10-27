import 'package:get/get.dart';

class SubjectsController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for the selected item

  // Function to change the selected index
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
