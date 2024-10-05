import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/choices_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Choices extends StatelessWidget {
  final String choiceText;
  final String choiceNumber;
  final int index;
  final ChoicesController controller = Get.put(ChoicesController());
  Choices({
    super.key,
    required this.choiceText,
    required this.choiceNumber,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            controller.selectChoice(index);
          },
          child: Obx(() => Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // Use the color based on whether this choice is selected
                color: controller.getChoiceColor(index),
              ),
              child: Center(
                child: Text(choiceNumber),
              ))),
        ),
        Text(choiceText),
      ],
    );
  }
}
