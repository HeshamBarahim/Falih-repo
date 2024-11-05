import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/themes.dart';
import '../models/exam.dart';
import '../screens/run_exam/widgets_run_exam/result_dialog.dart';

class ExamController extends GetxController {
  var questionIndex = 19.obs;
  var score = 0.obs;
  var trueAnswers = 0.obs;
  var falseAnswers = 0.obs;
  var examTime = 0.obs;
  var isGeneratingResponse = false.obs;
  var generatedResponse = "".obs;
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

  void moveToAnotherQuestion(BuildContext context) {
    // Check if the current question has an answer selected
    if (selectedAnswers[questionIndex.value] == null) {
      Get.snackbar("Alert", "Please select an answer before proceeding.");
      return;
    } else {
      if ((questionIndex.value <= questions.length - 1) &&
          (selectedAnswers[questionIndex.value] ==
              questions[questionIndex.value].correctAnswerIndex) &&
          (trueAnswers.value + falseAnswers.value < questions.length)) {
        score.value = score.value + 2;
        trueAnswers++;
      } else if ((questionIndex.value <= questions.length - 1) &&
          (selectedAnswers[questionIndex.value] !=
              questions[questionIndex.value].correctAnswerIndex) &&
          (trueAnswers.value + falseAnswers.value < questions.length)) {
        falseAnswers++;
      }
    }
    if (questionIndex.value < questions.length - 1) {
      questionIndex.value++;
    } else {
      print("show result");
      print(questionIndex.value);
      // Get.to(() => ResultsPage(score: score.value));
      showDialog(
        context: context,
        builder: (_) => ResultDialog(
          context: context,
        ),
      );
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

  generateResponse(String questionText) async {
    if (selectedAnswers[questionIndex.value] == null) {
      Get.snackbar("Alert", "Please select an answer to use the AI.");
      return;
    } else {
      isGeneratingResponse.value = true;
      final url = Uri.parse(
          'https://9od4u0fk03.execute-api.us-east-1.amazonaws.com/prod'); // Replace with your actual API URL

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'x-api-key': 'YOUR_API_KEY',  // Only if API Key Required is enabled
        },
        body: jsonEncode({
          'question': questionText,
          'userChoice': questions[questionIndex.value]
              .options[selectedAnswers[questionIndex.value]!],
          "choices": questions[questionIndex.value].options,
          "correctAnswer": questions[questionIndex.value]
              .options[questions[questionIndex.value].correctAnswerIndex]
        }),
      );
      // Used for debugging

      // print(
      //     'question' + questionText + 'userChoice: ' + questions[questionIndex.value].options[selectedAnswers[questionIndex.value]!] + "  choices: " + questions[questionIndex.value].options.toString() + "correctAnswer: " + questions[questionIndex.value].options[questions[questionIndex.value].correctAnswerIndex]
      // );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        generatedResponse.value = data['generation'];
        print("Answer: ${data['generation']}");
        isGeneratingResponse.value = false;
      } else {
        print("Error: ${response.statusCode}");
        print("Message: ${response.body}");
      }
    }
  }

  Color getChoiceColor(int index) {
    return index == questions[questionIndex.value].correctAnswerIndex
        ? AppColors.mainColor
        : AppColors.choicesColor;
  }

  // Filter type
  var filter = 'all'.obs;

  //  To get filtered questions based on selected filter
  List<Exam> get filteredQuestions {
    switch (filter.value) {
      case 'correct':
        return questions
            .asMap()
            .entries
            .where((entry) =>
        selectedAnswers[entry.key] == entry.value.correctAnswerIndex)
            .map((entry) => entry.value)
            .toList();
      case 'incorrect':
        return questions
            .asMap()
            .entries
            .where((entry) =>
        selectedAnswers[entry.key] != entry.value.correctAnswerIndex &&
            selectedAnswers[entry.key] != null)
            .map((entry) => entry.value)
            .toList();
      default:
        return questions;
    }
  }
}
