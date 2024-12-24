import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/screens/Auth/signup/signup_part1.dart';
import 'package:falih/src/screens/Auth/signup/signup_part2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());
  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Enable controlled back navigation
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (controller.currentPageIndex.value > 1) {
          // If on the second page, go back to the first page
          controller.goToPreviousPage();
        } else {
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
        body: Obx(() {
          return controller.currentPageIndex.value == 1
              ? SignupPart1()
              : SignupPart2();
        }),
      ),
    );
  }
}
