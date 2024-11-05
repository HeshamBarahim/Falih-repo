import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/after_exam/after_exam.dart';
import 'package:falih/src/screens/pre_exam/widgets_pre_exam/custom_app_bar.dart';
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
    final ExamController controller = Get.put(ExamController());
    final SubjectsController subjectController = Get.put(SubjectsController());

    return Scaffold(
      // appbar for the name of the subject
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(
          name: subjectController.name.value,
          color: subjectController.color,
        ),
      ),
      // container to set the backgroung gradinet color
      body: Container(
        padding: const EdgeInsets.all(25),
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
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: const Column(
                children: [
                  Text('Time will be counted during the exam'),
                  Text('You can continue take exam anytime ')
                ],
              ),
            ),
            // start taking the exam button
            GradientButton(
              text: 'Start taking the exam',
              height: 50,
              width: double.infinity,
              onClick: () {
                Get.to(() => const RunExam());
              },
            ),
          ],
        ),
      ),
    );
  }
}
