import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class Choices extends StatelessWidget {
  final String choiceText;
  final String choiceNumber;

  const Choices({
    super.key,
    required this.choiceText,
    required this.choiceNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {},
          child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.choicesColor),
              child: Center(
                child: Text(choiceNumber),
              )),
        ),
        // width space
        const SizedBox(
          width: 20,
        ),
        Text(choiceText),
      ],
    );
  }
}
