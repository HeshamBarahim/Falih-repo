import 'package:falih/generated/l10n.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/pre_exam/widgets_pre_exam/pre_exam_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/functions.dart';
import '../../controller/exam_controller.dart';
import '../../controller/subjects_controller.dart';

class PreExam extends StatelessWidget {
  const PreExam({super.key});

  @override
  Widget build(BuildContext context) {
    final ExamController controller = Get.find<ExamController>();
    final SubjectsController subjectController = Get.find<SubjectsController>();

    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          subjectController.changeSelectedIndex(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getSectionDisplayName(subjectController.name.value),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Get.isDarkMode
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColor,
                ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Get.isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),

              /// box of the questions and points
              PreExamBox(questionCount: controller.questions.length),

              /// box to set rules of the exam
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text("القواعد:",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 5),
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "• ", // Bullet point
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 30)),
                                  const TextSpan(
                                    text:
                                        "يجب التأكد من اختيار إجابة قبل الانتقال للسؤال التالي.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "• ", // Bullet point
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 30)),
                                  const TextSpan(
                                    text:
                                        "فالح، الاستاذ الذكي, سيتمكن من مساعدتك بعد اختيارك لإجابة.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "• ", // Bullet point
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 30)),
                                  const TextSpan(
                                    text:
                                        "إذا تكرّر السؤال، فهذا يعني أنه ظهر في عدة اختبارات سنوية.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "• ", // Bullet point
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 30)),
                                  const TextSpan(
                                    text:
                                        "إذا خرج الطالب من الاختبار دون إكماله، فلن يتم احتساب أي نقطة.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              // start taking the exam button
              GradientButton(
                text: S.of(context).start_taking_exam,
                height: 56,
                width: double.infinity,
                onClick: () {
                  controller.startTime = DateTime.now();
                  controller.startTimer();
                  Get.toNamed("exam");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
