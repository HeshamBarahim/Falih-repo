import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/dialogs.dart';
import '../models/exam_model.dart';

class ExamController extends GetxController {
  var questionIndex = 0.obs;
  var score = 0.obs;
  var trueAnswers = 0.obs;
  var falseAnswers = 0.obs;
  var examName = "".obs;
  var examGrade = "".obs;
  var examDepartment = "".obs;
  var examType = "".obs;
  var unitQuestionsCount = 10.obs;
  var filter = 'all'.obs;
  var isGeneratingResponse = false.obs;
  var hasChosenAnswer = false.obs;
  var generatedResponse = "".obs;
  late List<dynamic> units;
  var questions = <Exam>[].obs;
  var selectedAnswers = <int?>[].obs; // List to store selected answer indices
  var currentTime = 0.obs;
  DateTime? startTime;
  DateTime? endTime;
  Timer? timer;
  var timeTaken = ''.obs; // To store the formatted time taken

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setUnitQuestions(List<dynamic> questionData) {
    try {
      final List<Exam> loadedQuestions = questionData.map((data) {
        return Exam.fromMap(data as Map<String, dynamic>);
      }).toList()
        ..shuffle();
      questions
          .assignAll(loadedQuestions.take(unitQuestionsCount.value).toList());
      selectedAnswers
          .assignAll(List<int?>.filled(unitQuestionsCount.value, null));
      Get.toNamed("/pre-exam");
    } catch (error) {
      showErrorMessage("حدث خطأ, يرجى المحاولة مرة اخرى");
    }
  }

  void setExamQuestions() {
    // Calculate the total number of questions in all units
    var totalUnitsQuestions = units.fold(
        0,
        (sumOfQuestions, unit) =>
            sumOfQuestions + unit["questions"].length as int);
    // print(totalUnitsQuestions);

    List<dynamic> selected50Questions =
        []; // General list to store selected questions from all units

    for (var unit in units) {
      int unitQuestionCount = unit["questions"].length;

      // Calculate the percentage of total questions this unit holds
      double unitPercentage = (unitQuestionCount / totalUnitsQuestions) * 100;

      // Calculate the number of questions to take from this unit (based on a 50-question target)
      int selectedQuestionsCount = (unitPercentage * 50 / 100).round();
      //  Shuffle the questions and then take the required count
      final random = Random();
      List<dynamic> shuffledQuestions = List.from(unit["questions"])
        ..shuffle(random);
      List<dynamic> selectedQuestions =
          shuffledQuestions.take(selectedQuestionsCount).toList();

      // Add selected questions from the current unit to the general list
      selected50Questions.addAll(selectedQuestions);
    }

    // If the total number of selected questions is less than 50, add the remaining questions
    if (selected50Questions.length < 50) {
      int remainingQuestions = 50 - selected50Questions.length;

      // Sort units by the number of questions in descending order
      units.sort(
          (a, b) => b["questions"].length.compareTo(a["questions"].length));

      for (var unit in units) {
        if (remainingQuestions <= 0) break;

        // Get the questions that haven't been selected yet
        List<dynamic> remainingUnitQuestions = unit["questions"]
            .where((question) => !selected50Questions.contains(question))
            .toList();

        // Shuffle the remaining questions and take the required count
        final random = Random();
        remainingUnitQuestions.shuffle(random);
        List<dynamic> additionalQuestions =
            remainingUnitQuestions.take(remainingQuestions).toList();

        // Add the additional questions to the selected list
        selected50Questions.addAll(additionalQuestions);

        // Update the remaining questions count
        remainingQuestions -= additionalQuestions.length;
      }
    }

    // Shuffle the final list of selected questions
    selected50Questions.shuffle(Random());

    final List<Exam> loadedQuestions = selected50Questions.map((data) {
      return Exam.fromMap(data as Map<String, dynamic>);
    }).toList();
    questions.assignAll(loadedQuestions);
    selectedAnswers.assignAll(List<int?>.filled(loadedQuestions.length, null));
  }

  void selectAnswer(int selectedIndex) {
    if (!hasChosenAnswer.value) {
      selectedAnswers[questionIndex.value] =
          selectedIndex; // Save selected answer
      hasChosenAnswer.value = true;
      return;
    }
  }

  void moveToAnotherQuestion(BuildContext context) {
    // Check if the current question has an answer selected
    if (selectedAnswers[questionIndex.value] == null) {
      showInfoMessage(
          title: "يرجى اختيار إجابة",
          message: S.current.please_select_answer_before_proceeding);
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
    hasChosenAnswer.value = false;
    if (questionIndex.value < questions.length - 1) {
      questionIndex.value++;
    } else {
      stopTimer();
      showExamResult(context);
    }
  }

  void generateResponse(String questionText) async {
    if (selectedAnswers[questionIndex.value] == null) {
      showInfoMessage(
          title: "فالح", message: S.current.please_select_answer_to_use_ai);
      return;
    } else {
      isGeneratingResponse.value = true;
      var correctAnswer = questions[questionIndex.value]
          .options[questions[questionIndex.value].correctAnswerIndex];
      correctAnswer = correctAnswer.toLowerCase().trim() == "true" ||
          (correctAnswer.toLowerCase().trim() == "false")
          ? Get.locale?.languageCode == "ar"
              ? correctAnswer.toLowerCase().trim() == "true"
                  ? "صح"
                  : "خطأ"
              : correctAnswer.toLowerCase().trim() == "true"
                  ? "True"
                  : "False"
          : correctAnswer;
      if (questions[questionIndex.value].options[3] == "") {
        questions[questionIndex.value].options[0] = Get.locale?.languageCode ==
                "ar"
            ? questions[questionIndex.value].options[0].toLowerCase().trim() ==
                    "true"
                ? "صح"
                : "خطأ"
            : questions[questionIndex.value].options[0].toLowerCase().trim() ==
                    "true"
                ? "True"
                : "False";
        questions[questionIndex.value].options[1] = Get.locale?.languageCode ==
                "ar"
            ? questions[questionIndex.value].options[1].toLowerCase().trim() ==
                    "true"
                ? "صح"
                : "خطأ"
            : questions[questionIndex.value].options[1].toLowerCase().trim() ==
                    "true"
                ? "True"
                : "False";
      }

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
          "correctAnswer": correctAnswer,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data['generation'] =
            data['generation'].toString().replaceAll(RegExp(r'\n+'), '\n\n');

        generatedResponse.value = data['generation'];
        isGeneratingResponse.value = false;
      } else {
        showErrorMessage("حدث خطأ, يرجى المحاولة مرة اخرى");
        return;
      }
    }
  }

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

  int getAnswerCount(String filterName) {
    switch (filterName) {
      case 'correct':
        return questions
            .asMap()
            .entries
            .where((entry) =>
                selectedAnswers[entry.key] == entry.value.correctAnswerIndex)
            .map((entry) => entry.value)
            .toList()
            .length;
      case 'incorrect':
        return questions
            .asMap()
            .entries
            .where((entry) =>
                selectedAnswers[entry.key] != entry.value.correctAnswerIndex &&
                selectedAnswers[entry.key] != null)
            .map((entry) => entry.value)
            .toList()
            .length;
      case 'all':
        return questions.length;
      default:
        return questions.length;
    }
  }

  Future<void> saveExamResult() async {
    var points = calculateUserPoints();
    try {
      UserModel? user = UserController.instance.user.value;
      final examResult = {
        'examName': examName.value,
        "grade": examGrade.value,
        "department": examDepartment.value,
        'examType': examType.value,
        'score': score.value,
        'totalQuestions': questions.length,
        'correctAnswers': trueAnswers.value,
        'wrongAnswers': falseAnswers.value,
        'points': points,
        'timeTaken': timeTaken.value,
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

      resetExam();

      showSuccessMessage(
          title: S.current.success,
          message: S.current.exam_result_saved_successfully,
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      showErrorMessage(S.current.failed_to_save_exam);
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

  String formatTime(int seconds) {
    // Format seconds into MM:SS
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void startTimer() {
    // Start a timer that updates every second
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime.value++;
    });
  }

  void stopTimer() {
    if (timer != null) {
      if (timer!.isActive) {
        timer?.cancel();
        currentTime.value = 0;
      }
    }

    if (startTime != null && endTime == null) {
      endTime = DateTime.now();
      // Calculate the difference
      Duration? duration = endTime?.difference(startTime!);

      // Format the duration into hours, minutes, and seconds
      int? hours = duration?.inHours;
      int minutes = duration!.inMinutes % 60;
      int seconds = duration.inSeconds % 60;

      timeTaken.value = "${hours.toString().padLeft(2, '0')}:"
          "${minutes.toString().padLeft(2, '0')}:"
          "${seconds.toString().padLeft(2, '0')}";
    }
  }

  void resetExam() {
    stopTimer();
    questions.clear();
    selectedAnswers.clear();
    questionIndex.value = 0;
    score.value = 0;
    falseAnswers.value = 0;
    trueAnswers.value = 0;
    questionIndex.value = 0;
    // examName.value = "";
    // examGrade.value = "";
    // examDepartment.value = "";
    // examType.value = "";
    // examTime.value = 0;
    endTime = null;
    timeTaken.value = '';
    hasChosenAnswer.value = false;
  }

  void restartExam() {
    stopTimer();
    selectedAnswers
        .assignAll(List<int?>.filled(unitQuestionsCount.value, null));
    questionIndex.value = 0;
    score.value = 0;
    falseAnswers.value = 0;
    trueAnswers.value = 0;
    // examTime.value = 0;
    endTime = null;
    timeTaken.value = '';
    hasChosenAnswer.value = false;
  }

  @override
  void onClose() {
    // Ensure the timer is cleaned up when the controller is disposed
    if (timer != null) {
      if (timer!.isActive) {
        timer?.cancel();
      }
    }
    super.onClose();
  }
}
