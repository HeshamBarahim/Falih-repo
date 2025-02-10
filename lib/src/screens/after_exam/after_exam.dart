import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
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

    final ExamController controller = Get.find<ExamController>();
    final SubjectsController subjectController = Get.find<SubjectsController>();

    final List items = [
      {'value': 'all', 'name': S.of(context).all},
      {'value': 'correct', 'name': S.of(context).correct},
      {'value': 'incorrect', 'name': S.of(context).wrong},
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          backgroundColor: AppColors.moreLightenMainColor,
          title: Text(
            getSectionDisplayName(subjectController.name.value),
            style: const TextStyle(
              color: AppColors.mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        color: AppColors.moreLightenMainColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
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
                            ? AppColors.darkMainColor
                            : Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "${items[index]['name']} ${controller.getAnswerCount(items[index]['value'])}",
                          style: TextStyle(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                            color:
                            controller.filter.value == items[index]['value']
                                ? AppColors.secondaryColor
                                : AppColors.darkMainColor,
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
                      S.of(context).no_question,
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
                    var correctAnswer =
                        question.options[question.correctAnswerIndex];

                    correctAnswer =
                        correctAnswer.toLowerCase().trim() == "true" ||
                                (correctAnswer.toLowerCase().trim() == "false")
                            ? Get.locale?.languageCode == "ar"
                                ? correctAnswer.toLowerCase().trim() == "true"
                                    ? "صح"
                                    : "خطأ"
                                : correctAnswer.toLowerCase().trim() == "true"
                                    ? "True"
                                    : "False"
                            : correctAnswer;

                    var userAnswer = question.options[
                        controller.selectedAnswers[
                                controller.questions.indexOf(question)] ??
                            0];

                    userAnswer = userAnswer.toLowerCase().trim() == "true" ||
                            (userAnswer.toLowerCase().trim() == "false")
                        ? Get.locale?.languageCode == "ar"
                            ? userAnswer.toLowerCase().trim() == "true"
                                ? "صح"
                                : "خطأ"
                            : userAnswer.toLowerCase().trim() == "true"
                                ? "True"
                                : "False"
                        : userAnswer;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppColors.darkMainColor.withOpacity(0.90),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.mainColor.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question Number
                          Center(
                            child: Text(
                              "${S.of(context).question} ${controller.questions.indexOf(question) + 1}/${controller.questions.length}",
                              style: TextStyle(
                                color: AppColors.warningColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.02,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),

                          // Question Text
                          Text(
                            question.questionText,
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          // Your Answer
                          isCorrect
                              ? _buildAnswerText(
                                  "إجابتك الصحيحة هي: $correctAnswer",
                                  AppColors.successDarkColor,
                                  isSelectedAnswer: false,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildAnswerText(
                                      "إجابتك هي: $userAnswer",
                                      AppColors.errorColor,
                                      isSelectedAnswer: true,
                                    ),
                                    SizedBox(height: screenHeight * 0.015),

                                    // Correct Answer
                                    _buildAnswerText(
                                      "الإجابة الصحيحة هي: $correctAnswer",
                                      AppColors.successDarkColor,
                                      isSelectedAnswer: false,
                                    ),
                                  ],
                                )
                          // SizedBox(height: screenHeight * 0.02),

                          // Result Button (Correct or Wrong)
                          // Container(
                          //   width: screenWidth * 0.35,
                          //   alignment: Alignment.center,
                          //   decoration: BoxDecoration(
                          //     color: isCorrect
                          //         ? AppColors.successColor.withOpacity(0.2)
                          //         : Colors.red.withOpacity(0.2),
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          //   padding: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.08,
                          //     vertical: screenHeight * 0.015,
                          //   ),
                          //   child: Text(
                          //     isCorrect ? S.of(context).correct : S.of(context).wrong,
                          //     style: TextStyle(
                          //       color: isCorrect
                          //           ? AppColors.successColor
                          //           : Colors.red,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: screenHeight * 0.02,
                          //       letterSpacing: 1.2,
                          //     ),
                          //   ),
                          // ),
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

  Widget _buildAnswerText(String answerText, Color textColor,
      {bool isSelectedAnswer = true}) {
    return Container(
      decoration: BoxDecoration(
        color: isSelectedAnswer
            ? Colors.red.withOpacity(0.1)
            : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelectedAnswer ? Colors.red : AppColors.successColor,
          width: 1.2,
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.05,
          vertical: SizeConfig.screenHeight! * 0.015),
      child: Text(
        answerText,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  String getSectionDisplayName(String key) {
    // print("fksjgjgskgj $key");
    switch (key) {
      case "geography":
        return "جغرافيا";
      case "history":
        return "تاريخ";
      case "nationalism":
        return "وطنية";
      case "physics":
        return S.current.subject_six;
      case "biology":
        return S.current.subject_seven;
      case "chemistry":
        return S.current.subject_five;
      case "iman":
        return "ُالإيمان";
      case "fiqh":
        return "الفقة";
      case "hadith":
        return "الحديث";
      case "seerah":
        return "السيرة";
      case "grammar_morphology":
        return "النحو والصرف";
      case "literature_texts":
        return "الأدب والنصوص";
      case "reading":
        return "القراءة";
      case "criticism":
        return "النقد";
      case "tafsir_alquran":
        return "الحفظ والتفسير";
      case "uloom_alquran":
        return "علوم القرآن";
      case "tajweed":
        return "التجويد";
      case "quran":
        return S.current.subject_one;
      case "arabic":
        return S.current.subject_three;

      default:
        return key.capitalizeFirst ?? key;
    }
  }
}
