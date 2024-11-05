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
    // final LinearGradient color = Get.arguments['color'];
    final ExamController controller = Get.put(ExamController());
    final SubjectsController subjectController = Get.put(SubjectsController());

    final List items = [
      {
        'value': 'all',
        'name': 'All',
      },
      {
        'value': 'correct',
        'name': 'Correct',
      },
      {
        'value': 'incorrect',
        'name': 'Wrong',
      },
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(
          name: subjectController.name.value,
          color: subjectController.color,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(gradient: subjectController.color),
        child: Column(
          children: [
            // Row of filter buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(items.length, (index) {
                return InkWell(
                  onTap: () {
                    print(controller.falseAnswers);
                    controller.filter.value = items[index]['value'];
                  },
                  child: Obx(() => Container(
                        padding: const EdgeInsets.all(10),
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2.5, color: AppColors.mainColor),
                          color:
                              // the clicked button get the whole opacity
                              controller.filter.value == items[index]['value']
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                              "${items[index]['name']} ${controller.filteredQuestions.length}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                      )),
                );
              }),
            ),

            const SizedBox(height: 20),

            // Filtered list of questions
            Expanded(
              child: Obx(() {
                final questionsToDisplay = controller.filteredQuestions;
                if (questionsToDisplay.isEmpty) {
                  return const Center(child: Text("No questions to display"));
                }
                return ListView.builder(
                  itemCount: questionsToDisplay.length,
                  itemBuilder: (context, index) {
                    final question = questionsToDisplay[index];
                    final isCorrect = controller.selectedAnswers[
                            controller.questions.indexOf(question)] ==
                        question.correctAnswerIndex;
                    // box of question
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // number of question
                          Text(
                            "${S.of(context).question} ${controller.questions.indexOf(question) + 1}/${controller.questions.length}",
                            style: const TextStyle(
                              color: AppColors.warningColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // the text of the question
                          SizedBox(
                            height: 70,
                            child: Text(
                              question.questionText,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                          // box weather the question is true or false
                          Container(
                            width: 120,
                            height: 40,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? AppColors.successColor.withOpacity(0.25)
                                  : Colors.red.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
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
