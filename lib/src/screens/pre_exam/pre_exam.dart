import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/pre_exam/widgets_pre_exam/pre_exam_box.dart';
import 'package:falih/src/screens/run_exam/run_exam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/exam_controller.dart';
import '../../controller/subjects_controller.dart';

class PreExam extends StatelessWidget {
  const PreExam({super.key});

  @override
  Widget build(BuildContext context) {
    final ExamController controller = Get.find<ExamController>();
    final SubjectsController subjectController = Get.find<SubjectsController>();

    return Scaffold(
      // appbar for the name of the subject
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: subjectController.color),
          ),
          title: Text(
            subjectController.name.value.capitalizeFirst ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(gradient: subjectController.color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            // box of the questions and points
            PreExamBox(questionCount: controller.questions.length),
            // box to set rules of the exam
            Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.choicesColor, width: 5),
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.isFinalExam.value == true
                        ? Row(
                            children: [
                              const Text("• ", style: TextStyle(fontSize: 20)),
                              // Bullet symbol
                              Expanded(
                                child: Text(
                                  S.of(context).exam_simulation,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkMainColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        const Text("• ",
                            style: TextStyle(
                                fontSize: 40, color: AppColors.darkMainColor)),
                        // Bullet symbol
                        Expanded(
                          child: Text(
                            S.of(context).time_will_counted,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkMainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("• ", style: TextStyle(fontSize: 40)),
                        // Bullet symbol
                        Expanded(
                          child: Text(
                            S.of(context).you_can_continue,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkMainColor,
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
                Get.to(() => const RunExam());
              },
            ),
          ],
        ),
      ),
    );
  }
}
