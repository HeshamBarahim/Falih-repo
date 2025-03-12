import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController cardName = TextEditingController();

  int paymentType = 0;
  var selectedIndex = 0.obs;

  List<Map<String, dynamic>> paymentOptions = [
    {
      "title": "Kuraimi",
      "icon": CupertinoIcons.creditcard_fill,
    },
    {
      "title": "JaiB",
      "icon": Icons.apple,
    },
    // {
    //   "title": "PayPal",
    //   "icon": Icons.payment,
    // },
  ];

  void selectPayment(int index) {
    selectedIndex.value = index;
    paymentType = index;
    update();
  }

  void creditCardChoice() {
    paymentType = 0;
    update();
  }

  void kuraimiChoice() {
    paymentType = 1;
    update();
  }
}
