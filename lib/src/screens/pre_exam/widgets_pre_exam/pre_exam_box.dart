import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class PreExamBox extends StatelessWidget {
  const PreExamBox({super.key, required this.questionCount});

  final int questionCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.choicesColor, width: 5),
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "مجموع الاسئلة",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.choicesColor),
                    width: 75,
                    child: Center(
                      child: Text(
                        "$questionCount",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "إجمالي النقاط في الاختبار",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.choicesColor),
                    width: 75,
                    child: Center(
                      child: Text(
                        questionCount == 10 ? "17" : "118",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Circular for the exclamation mark
        Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.darkMainColor, width: 3),
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.secondaryColor),
                  child: const Center(
                      child: Text(
                    '0:00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ))),
            ))
      ],
    );
  }
}
