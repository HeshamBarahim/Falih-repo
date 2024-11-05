import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/run_exam/widgets_run_exam/ai_bottom_sheet.dart';
import 'package:falih/src/screens/run_exam/widgets_run_exam/result_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/exam_controller.dart';
import '../../controller/subjects_controller.dart';
import '../after_exam/after_exam.dart';

class RunExam extends StatelessWidget {
  const RunExam({super.key});

  @override
  Widget build(BuildContext context) {
    final SubjectsController subjectController = Get.put(SubjectsController());
    final ExamController controller = Get.put(ExamController());

    return Scaffold(
      body: Obx(() {
        if (controller.questions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final question = controller.questions[controller.questionIndex.value];
        final questionNumber = controller.questionIndex.value;
        final selectedAnswer =
            controller.selectedAnswers[controller.questionIndex.value];

        return Container(
          padding: const EdgeInsets.all(25),
          height: double.infinity,
          decoration: BoxDecoration(gradient: subjectController.color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  // Question box
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green),
                                  width: 50,
                                  child: Center(
                                      child: Text(
                                          '${controller.trueAnswers.value}')),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red),
                                  width: 50,
                                  child: Center(
                                      child: Text(
                                          '${controller.falseAnswers.value}')),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // Question number of 50
                            Text(
                              "${S.of(context).question} ${questionNumber + 1}/${controller.questions.length}",
                              style: const TextStyle(
                                  color: AppColors.warningColor),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Question Text
                            Text(question.questionText),
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
                                child: Center(
                                    child: Text('${controller.score.value}'))),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          ...question.options.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            if (option == "") {
                              return Container();
                            }
                            return Row(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    controller.selectAnswer(idx);
                                  },
                                  child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          // Use the color based on whether this choice is selected
                                          color: selectedAnswer == idx
                                              ? AppColors.mainColor
                                              : AppColors.choicesColor),
                                      child: Center(
                                        child: Text((idx + 1).toString()),
                                      )),
                                ),
                                Text(option),
                              ],
                            );
                          }).toList(),
                        ],
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
              Column(
                children: [
                  // AI button
                  GradientButton(
                    text: 'AI',
                    height: 50,
                    width: 100,
                    onClick: () {
                      controller.selectedAnswers[
                                  controller.questionIndex.value] !=
                              null
                          ? showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => AIBottomSheet())
                          : null;
                      controller.generateResponse(question.questionText);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GradientButton(
                    text: S.of(context).continueText,
                    height: 50,
                    width: double.infinity,
                    onClick: () {
                      controller.moveToAnotherQuestion(context);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     controller.name.value = name;
                  //     controller.color = color;
                  //     Get.to(() => const AfterExam(), arguments: {
                  //       "color": color,
                  //       "name": name,
                  //     });
                  //   },
                  //   child: Text('result page'),
                  // ),
                  // this dialog shuld be shown once the question finished
                  // ElevatedButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => ResultDialog(
                  //         reviewAnswer: 'reviewAnswer',
                  //         numberOfQuestion: '50',
                  //         score: '66',
                  //         time: '16:14',
                  //         trueAnswers: '23',
                  //         wrongAnswers: '27',
                  //       ),
                  //     );
                  //   },
                  //   child: const Text('Dialog'),
                  // )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
