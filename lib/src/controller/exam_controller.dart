import 'dart:ui';

import 'package:get/get.dart';

import '../config/themes.dart';
import '../models/exam.dart';

class ExamController extends GetxController {
  var questionIndex = 0.obs;
  var score = 0.obs;
  var trueAnswers = 0.obs;
  var falseAnswers = 0.obs;

  // final List<Exam> questions = [
  //   // Add 30 questions
  //   Exam(
  //     questionText: 'Question 1',
  //     options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  //     correctAnswerIndex: 1,
  //   ),
  //   // Add more questions...
  // ];
  var questions = <Exam>[].obs;
  var selectedAnswers = <int?>[].obs; // List to store selected answer indices

  void setQuestions(List<dynamic> questionData) {
    final List<Exam> loadedQuestions = questionData.map((data) {
      return Exam.fromMap(data as Map<String, dynamic>);
    }).toList();
    questions.assignAll(loadedQuestions);
    selectedAnswers.assignAll(List<int?>.filled(loadedQuestions.length, null));
  }

  void selectAnswer(int selectedIndex) {
    selectedAnswers[questionIndex.value] =
        selectedIndex; // Save selected answer
  }

  void moveToAnotherQuestion() {
    // Check if the current question has an answer selected
    if (selectedAnswers[questionIndex.value] == null) {
      Get.snackbar("Alert", "Please select an answer before proceeding.");
      return;
    } else {
      if (selectedAnswers[questionIndex.value] ==
          questions[questionIndex.value].correctAnswerIndex) {
        score.value = score.value + 2;
        trueAnswers++;
      } else {
        falseAnswers++;
      }
    }
    if (questionIndex.value < questions.length - 1) {
      questionIndex.value++;
    } else {
      // Get.to(() => ResultsPage(score: score.value));
    }
  }

  // Function to clear all data and reset the quiz
  void resetExam() {
    questions.clear();
    selectedAnswers.clear();
    questionIndex.value = 0;
    score.value = 0;
    falseAnswers.value = 0;
    trueAnswers.value = 0;
  }

  Color getChoiceColor(int index) {
    return index == questions[questionIndex.value].correctAnswerIndex
        ? AppColors.mainColor
        : AppColors.choicesColor;
  }
}
