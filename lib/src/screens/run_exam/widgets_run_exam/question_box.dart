import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  const QuestionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              // true and false boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    width: 50,
                    child: const Center(child: Text('11')),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    width: 50,
                    child: const Center(child: Text('22')),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              // Question number of 50
              const Text(
                "Questions 33/50",
                style: TextStyle(color: AppColors.warningColor),
              ),
              const SizedBox(
                height: 20,
              ),
              // Question Text
              const Text(
                  'AskgsgsAskgskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgs   gskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgs  gskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgsAskgs  '),
            ],
          ),
        ),
        // Circular for the number question
        Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.secondaryColor),
                  child: const Center(child: Text('30'))),
            ))
      ],
    );
  }
}
