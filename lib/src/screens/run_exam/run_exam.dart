import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/run_exam/widgets_run_exam/ai_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/sizes.dart';
import '../../controller/exam_controller.dart';
import '../../controller/subjects_controller.dart';

class RunExam extends StatelessWidget {
  const RunExam({super.key});

  @override
  Widget build(BuildContext context) {
    final SubjectsController subjectController = Get.put(SubjectsController());
    final ExamController controller = Get.put(ExamController());
    SizeConfig().init(context);
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
          padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.06),
          height: double.infinity,
          decoration: BoxDecoration(gradient: subjectController.color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight! * 0.12),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.06),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                  ),
                                  width: SizeConfig.screenWidth! * 0.12,
                                  child: Center(
                                      child: Text(
                                          '${controller.trueAnswers.value}')),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  width: SizeConfig.screenWidth! * 0.12,
                                  child: Center(
                                      child: Text(
                                          '${controller.falseAnswers.value}')),
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight! * 0.01),
                            Text(
                              "${S.of(context).question} ${questionNumber + 1}/${controller.questions.length}",
                              style: TextStyle(color: AppColors.warningColor),
                            ),
                            SizedBox(height: SizeConfig.screenHeight! * 0.03),
                            Text(
                              question.questionText,
                              style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.025),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Transform.translate(
                          offset: Offset(0, -SizeConfig.screenHeight! * 0.05),
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.18,
                            height: SizeConfig.screenWidth! * 0.18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.secondaryColor,
                            ),
                            child: Center(
                              child: Text(
                                '${controller.score.value}',
                                style:
                                    TextStyle(fontSize: SizeConfig.screenHeight! * 0.025),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.04),
                  Container(
                    padding: EdgeInsets.only(bottom: SizeConfig.screenHeight! * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                                  width: SizeConfig.screenWidth! * 0.08,
                                  height: SizeConfig.screenWidth! * 0.08,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: selectedAnswer == idx
                                        ? AppColors.mainColor
                                        : AppColors.choicesColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      (idx + 1).toString(),
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenHeight! * 0.02),
                                    ),
                                  ),
                                ),
                              ),
                              Text(option),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.05),
                ],
              ),
              Column(
                children: [
                  GradientButton(
                    text: 'AI',
                    height: SizeConfig.screenHeight! * 0.06,
                    width: SizeConfig.screenWidth! * 0.25,
                    onClick: () {
                      controller.selectedAnswers[
                                  controller.questionIndex.value] !=
                              null
                          ? showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => AIBottomSheet(),
                            )
                          : null;
                      controller.generateResponse(question.questionText);
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.015),
                  GradientButton(
                    text: S.of(context).continueText,
                    height: SizeConfig.screenHeight! * 0.06,
                    width: SizeConfig.screenWidth!,
                    onClick: () {
                      controller.moveToAnotherQuestion(context);
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.06),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
