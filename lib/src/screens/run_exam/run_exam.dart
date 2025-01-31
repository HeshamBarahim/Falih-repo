import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/run_exam/widgets_run_exam/ai_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/images.dart';
import '../../config/sizes.dart';
import '../../constants/functions.dart';
import '../../controller/exam_controller.dart';

class RunExam extends StatelessWidget {
  const RunExam({super.key});

  @override
  Widget build(BuildContext context) {
    final ExamController controller = Get.find<ExamController>();
    SizeConfig().init(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          bool confirmExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Exit Exam"),
              content: const Text("Are you sure you want to exit the exam?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  // Stay in exam
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true); // Allow exit
                    Get.back(); // Pop the exam screen
                  },
                  child: const Text("Exit"),
                ),
              ],
            ),
          );

          if (confirmExit == true) {
            controller.resetExam();
            Get.back(); // Navigate back only if confirmed
          }
        }
      },
      child: Scaffold(
        body: Obx(() {
          if (controller.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final question = controller.questions[controller.questionIndex.value];
          final questionNumber = controller.questionIndex.value;
          final selectedAnswer =
              controller.selectedAnswers[controller.questionIndex.value];

          return Container(
            padding: const EdgeInsets.all(16),
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.lightenMainColor,
            ),
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
                          height: SizeConfig.screenHeight! * 0.28,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.mainColor, width: 2),
                            color: AppColors.customGrey,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.darkMainColor.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 12,
                                offset: const Offset(
                                    0, 10), // Shadow position (x, y)
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: isArabic(question.questionText)
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                    ),
                                    width: SizeConfig.screenWidth! * 0.12,
                                    child: Center(
                                      child: Text(
                                        '${controller.trueAnswers.value}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red,
                                    ),
                                    width: SizeConfig.screenWidth! * 0.12,
                                    child: Center(
                                      child: Text(
                                        '${controller.falseAnswers.value}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.screenHeight! * 0.01),
                              Center(
                                child: Text(
                                  "${S.of(context).question} ${questionNumber + 1}/${controller.questions.length}",
                                  style: const TextStyle(
                                      color: AppColors.warningColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight! * 0.03),
                              Directionality(
                                textDirection: isArabic(question.questionText)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: Text(
                                  question.questionText,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
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
                                  border: Border.all(
                                      color: AppColors.darkMainColor, width: 3),
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.choicesColor),
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    controller.formatTime(
                                        controller.currentTime.value),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.02),
                    Column(
                      children: [
                        ...question.options.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String option = entry.value;
                          if (option == "") {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: InkWell(
                              onTap: () {
                                controller.selectAnswer(idx);
                              },
                              child: Container(
                                height: SizeConfig.screenHeight! * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedAnswer == idx
                                      ? AppColors.darkMainColor
                                      : AppColors.mainColor.withOpacity(0.60),
                                  border: Border.all(
                                    color: selectedAnswer != null &&
                                            question.correctAnswerIndex == idx
                                        ? AppColors
                                            .successColor // Border color when selected
                                        : selectedAnswer == idx
                                            ? AppColors.errorColor
                                            : Colors.transparent,
                                    // Border color when not selected
                                    width: 2, // Adjust border width as needed
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          (idx + 1).toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.choicesColor),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        option.toLowerCase().trim() == "true" ||
                                                (option.toLowerCase().trim() ==
                                                    "false")
                                            ? Get.locale?.languageCode == "ar"
                                                ? option.toLowerCase().trim() ==
                                                        "true"
                                                    ? "صح"
                                                    : "خطأ"
                                                : option.toLowerCase().trim() ==
                                                        "true"
                                                    ? "True"
                                                    : "False"
                                            : option,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColors.moreLightenMainColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.moveToAnotherQuestion(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.darkMainColor),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Icon(
                                size: 28,
                                Icons.navigate_before,
                                color: AppColors.moreLightenMainColor,
                              ),
                              Text(
                                S.of(context).continueText,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.moreLightenMainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 64,
                            width: 64,
                            child: Image.asset(
                              Images.falih,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
