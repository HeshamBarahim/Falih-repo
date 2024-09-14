import 'package:get/get.dart';

class SignupController extends GetxController {
  //  manage checkbox state
  var isChecked = false.obs;

  //  toggle the checkbox
  void toggleCheckbox(bool value) {
    isChecked(value);
  }
}
