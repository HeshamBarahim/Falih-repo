import 'package:get/get.dart';

class PaymentChoiceController extends GetxController {
  int paymentType = 0;

  void creditCardChoice() {
    paymentType = 0;
    update();
  }

  void kuraimiChoice() {
    paymentType = 1;
    update();
  }
}
