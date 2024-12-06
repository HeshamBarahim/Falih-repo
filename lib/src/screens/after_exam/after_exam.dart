import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/pre_exam/widgets_pre_exam/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/exam_controller.dart';
import '../../controller/subjects_controller.dart';

class AfterExam extends StatelessWidget {
  const AfterExam({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final ExamController controller = Get.put(ExamController());
    final SubjectsController subjectController = Get.put(SubjectsController());

    final List items = [
      {'value': 'all', 'name': 'All'},
      {'value': 'correct', 'name': 'Correct'},
      {'value': 'incorrect', 'name': 'Wrong'},
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: CustomAppBar(
          name: subjectController.name.value,
          color: subjectController.color,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.03,
        ),
        decoration: BoxDecoration(gradient: subjectController.color),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(items.length, (index) {
                return InkWell(
                  onTap: () {
                    controller.filter.value = items[index]['value'];
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.012,
                      ),
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.5,
                          color: AppColors.mainColor,
                        ),
                        color: controller.filter.value == items[index]['value']
                            ? Colors.white
                            : Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "${items[index]['name']} ${controller.filteredQuestions.length}",
                          style: TextStyle(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: Obx(() {
                final questionsToDisplay = controller.filteredQuestions;
                if (questionsToDisplay.isEmpty) {
                  return Center(
                    child: Text(
                      "No questions to display",
                      style: TextStyle(
                        fontSize: screenHeight * 0.018,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: questionsToDisplay.length,
                  itemBuilder: (context, index) {
                    final question = questionsToDisplay[index];
                    final isCorrect = controller.selectedAnswers[
                            controller.questions.indexOf(question)] ==
                        question.correctAnswerIndex;

                    return Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      height: screenHeight * 0.25,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${S.of(context).question} ${controller.questions.indexOf(question) + 1}/${controller.questions.length}",
                            style: TextStyle(
                              color: AppColors.warningColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.018,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.1,
                            child: Text(
                              question.questionText,
                              style: TextStyle(
                                fontSize: screenHeight * 0.019,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.05,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? AppColors.successColor.withOpacity(0.25)
                                  : Colors.red.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.07,
                              vertical: screenHeight * 0.01,
                            ),
                            child: Center(
                              child: Text(
                                isCorrect
                                    ? S.of(context).correct
                                    : S.of(context).wrong,
                                style: TextStyle(
                                  color: isCorrect
                                      ? AppColors.successColor
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight * 0.018,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
