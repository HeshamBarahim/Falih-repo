import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/controller/subjects_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/themes.dart';
import '../models/exam_model.dart';
import '../screens/run_exam/widgets_run_exam/result_dialog.dart';

class ExamController extends GetxController {
  var questionIndex = 0.obs;
  var score = 0.obs;
  var trueAnswers = 0.obs;
  var falseAnswers = 0.obs;
  var examType = "".obs;
  var examTime = 0.obs;
  var unitQuestionsCount = 10.obs;
  var isFinalExam = false.obs;
  var isGeneratingResponse = false.obs;
  var generatedResponse = "".obs;
  late List<dynamic> units;
  var questions = <Exam>[].obs;
  var selectedAnswers = <int?>[].obs; // List to store selected answer indices

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SubjectsController subjectController = Get.put(SubjectsController());

  void setUnitQuestions(List<dynamic> questionData) {
    final List<Exam> loadedQuestions = questionData.map((data) {
      return Exam.fromMap(data as Map<String, dynamic>);
    }).toList()
      ..shuffle();
    questions
        .assignAll(loadedQuestions.take(unitQuestionsCount.value).toList());
    selectedAnswers
        .assignAll(List<int?>.filled(unitQuestionsCount.value, null));
  }

  void setExamQuestions() {
    isFinalExam.value = true;
    // Calculate the total number of questions in all units
    var totalUnitsQuestions =
        units.fold(0, (sum, unit) => sum + unit["questions"].length as int);
    // print(totalUnitsQuestions);

    List<dynamic> selected_50_Questions =
        []; // General list to store selected questions from all units

    for (var unit in units) {
      int unitQuestionCount = unit["questions"].length;

      // Calculate the percentage of total questions this unit holds
      double unitPercentage = (unitQuestionCount / totalUnitsQuestions) * 100;

      // Calculate the number of questions to take from this unit (based on a 50-question target)
      int selectedQuestionsCount = (unitPercentage * 50 / 100).round();
      print(
          "Unit percentage: ${unitPercentage}, selected questions: $selectedQuestionsCount");

      //  Shuffle the questions and then take the required count
      final random = Random();
      List<dynamic> shuffledQuestions = List.from(unit["questions"])
        ..shuffle(random);
      List<dynamic> selectedQuestions =
          shuffledQuestions.take(selectedQuestionsCount).toList();

      // Add selected questions from the current unit to the general list
      selected_50_Questions.addAll(selectedQuestions);
    }
    // Questions from all units
    selected_50_Questions = List.from(selected_50_Questions)..shuffle(Random());
    print("Total selected questions: ${selected_50_Questions.length}");

    final List<Exam> loadedQuestions = selected_50_Questions.map((data) {
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
    isFinalExam.value = false;
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        generatedResponse.value = data['generation'];
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

  Future<void> saveExamResult() async {
    var points = calculateUserPoints();
    try {
      UserModel? user = UserController.instance.user.value;
      final examResult = {
        'examName': subjectController.name.value.capitalize,
        "grade": user?.selectedGrade,
        'examType': examType.value,
        'score': score.value,
        'totalQuestions': questions.length,
        'correctAnswers': trueAnswers.value,
        'wrongAnswers': falseAnswers.value,
        'points': points,
        'date': Timestamp.now(),
        'answers': selectedAnswers,
      };

      // Save result to Firestore

      await _firestore
          .collection('exams')
          .doc(user?.id) // user id from firebase
          .collection('userExams')
          .doc()
          .set(examResult);

      Get.snackbar(
        'Success',
        'Exam result saved successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to save exam result: $error',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  int calculateUserPoints() {
    int points = 0;

    // Attempting the Exam(Finishing the whole exam)
    points += examType.value == "UnitExam" ? 2 : 3;

    // Correct Answer points
    points += examType.value == "UnitExam"
        ? trueAnswers.value
        : (trueAnswers.value * 2);

    // Perfect Score points for unit exam
    points +=
        examType.value == "UnitExam" && questions.length == trueAnswers.value
            ? 5
            : 0;

    // Perfect Score points for final exam
    points +=
        examType.value == "FinalExam" && questions.length == trueAnswers.value
            ? 15
            : 0;

    return points;
  }
}
