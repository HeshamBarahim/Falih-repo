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
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondary, width: 5),
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("مجموع الاسئلة",
                      style: Theme.of(context).textTheme.titleSmall),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.secondary),
                    width: 75,
                    child: Center(
                      child: Text(
                        "$questionCount",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
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
                  Text("إجمالي النقاط في الاختبار",
                      style: Theme.of(context).textTheme.titleSmall),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.secondary),
                    width: 75,
                    child: Center(
                      child: Text(
                        questionCount == 10 ? "17" : "118",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
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
                      color: Theme.of(context).colorScheme.secondary),
                  child: Center(
                      child: Text('0:00',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)))),
            ))
      ],
    );
  }
}
