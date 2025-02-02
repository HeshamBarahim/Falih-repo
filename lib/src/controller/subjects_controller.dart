import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../config/images.dart';
import '../config/themes.dart';
import '../screens/pre_exam/pre_exam.dart';
import 'exam_controller.dart';

class SubjectsController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedSectionIndex = 0.obs;
  var name = "".obs;
  var id = "".obs;
  late LinearGradient color;
  late String iconPath;
  var subjects = <Map<String, dynamic>>[].obs;
  var user = UserController.instance.user.value.obs;
  final _db = FirebaseFirestore.instance;
  var curriculumGrade = "".obs;
  var curriculumDepartment = "".obs;
  final ExamController _examController = Get.put(ExamController());

  final subjectSections = {
    "9": {
      "social_studies": ["geography", "history", "nationalism"],
      "science": ["physics", "biology", "chemistry"],
      "islamic": ["iman", "fiqh", "hadith", "seerah"],
      "quran": ["tafsir_alquran", "tajweed"]
    },
    "12": {
      "islamic": ["iman", "fiqh", "hadith", "seerah"],
      "arabic": [
        "grammar_morphology",
        "literature_texts",
        "reading",
        "criticism"
      ],
      "quran": ["tafsir_alquran", "uloom_alquran", "tajweed"]
    },
  };

  @override
  void onInit() {
    curriculumGrade.value = user.value?.selectedGrade ?? "";
    curriculumDepartment.value = user.value?.selectedDepartment ?? "";
    _examController.examGrade.value = curriculumGrade.value;
    _examController.examDepartment.value = curriculumDepartment.value;
    loadSubjects();
    super.onInit();
  }

  // Function to change the selected index
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void changeSelectedSectionIndex(int index) {
    selectedSectionIndex.value = index;
  }

  void subjectNameFetcher(int subjectIndex) {
    if (subjectSections[curriculumGrade.value]?[id.value] == null) {
      name.value = id.value;
      _examController.examName.value = name.value;
      _examController.examType.value = "UnitExam";
      return;
    }

    if (subjectIndex ==
        (subjectSections[curriculumGrade.value]?[id.value]!.length)) {
      name.value = "All";
    } else if (curriculumGrade.value == "9" &&
        (id.value == "social_studies" ||
            id.value == "science" ||
            id.value == "islamic" ||
            id.value == "quran")) {
      name.value = subjectSections[curriculumGrade.value]
              ?[id.value]![subjectIndex] ??
          "";
    } else if (curriculumGrade.value == "12" &&
        (id.value == "islamic" ||
            id.value == "arabic" ||
            id.value == "quran")) {
      name.value = subjectSections[curriculumGrade.value]
              ?[id.value]![subjectIndex] ??
          "";
    } else {
      name.value = id.value;
    }
    _examController.examName.value = name.value;
    _examController.examType.value = "UnitExam";
  }

  void loadSubjects() {
    if (curriculumGrade.value == "12") {
      subjects.assignAll([
        {
          'id': "quran",
          'name': S.current.subject_one,
          'color': AppColors.quranColor,
          'icon': Images.quranIcon,
        },
        {
          'id': "islamic",
          'name': S.current.subject_two,
          'color': AppColors.islamicColor,
          'icon': Images.islamicIcon
        },
        {
          'id': "arabic",
          'name': S.current.subject_three,
          'color': AppColors.arabicColor,
          'icon': Images.arabicIcon
        },
        {
          'id': "english",
          'name': S.current.subject_four,
          'color': AppColors.englisColor,
          'icon': Images.englishIcon
        },
        {
          'id': "chemistry",
          'name': S.current.subject_five,
          'color': AppColors.chemistyColor,
          'icon': Images.chemistryIcon
        },
        {
          'id': "physics",
          'name': S.current.subject_six,
          'color': AppColors.physicsColor,
          'icon': Images.physicsIcon
        },
        {
          'id': "biology",
          'name': S.current.subject_seven,
          'color': AppColors.biologyColor,
          'icon': Images.biologyIcon
        },
        {
          'id': "math",
          'name': S.current.subject_eight,
          'color': AppColors.mathColor,
          'icon': Images.mathIcon
        },
      ]);
    } else if (curriculumGrade.value == "9") {
      subjects.assignAll([
        {
          'id': "quran",
          'name': S.current.subject_one,
          'color': AppColors.quranColor,
          'icon': Images.quranIcon,
        },
        {
          'id': "islamic",
          'name': S.current.subject_two,
          'color': AppColors.islamicColor,
          'icon': Images.islamicIcon
        },
        {
          'id': "arabic",
          'name': S.current.subject_three,
          'color': AppColors.arabicColor,
          'icon': Images.arabicIcon
        },
        {
          'id': "english",
          'name': S.current.subject_four,
          'color': AppColors.englisColor,
          'icon': Images.englishIcon
        },
        // {
        //   'id': "chemistry",
        //   'name': S.current.subject_five,
        //   'color': AppColors.chemistyColor,
        //   'icon': Images.chemistryIcon
        // },
        // {
        //   'id': "physics",
        //   'name': S.current.subject_six,
        //   'color': AppColors.physicsColor,
        //   'icon': Images.physicsIcon
        // },
        // {
        //   'id': "biology",
        //   'name': S.current.subject_seven,
        //   'color': AppColors.biologyColor,
        //   'icon': Images.biologyIcon
        // },
        {
          'id': "science",
          'name': S.current.science,
          'color': AppColors.biologyColor,
          'icon': Images.biologyIcon
        },
        {
          'id': "math",
          'name': S.current.subject_eight,
          'color': AppColors.mathColor,
          'icon': Images.mathIcon
        },
        {
          'id': "social_studies",
          'name': S.current.subject_nine,
          'color': AppColors.socialStudiesColor,
          'icon': Images.socialStudiesIcon
        },
      ]);
    }
  }

  bool isSubjectWithSections() {
    if (subjectSections[curriculumGrade.value]?[id.value] == null) {
      return false;
    }
    return true;
  }

  Future<void> startFinalExam(int subjectIndex) async {
    if (subjectIndex == -1) {
      // changeSelectedSectionIndex(0);

      List<Map<String, dynamic>> allSectionUnits = [];
      for (var sectionName
          in subjectSections[curriculumGrade.value]![id.value]!) {
        final DocumentSnapshot<Map<String, dynamic>> subjectSectionUnits = await _db
            .collection(
                'subjects_${curriculumDepartment.toString().toLowerCase()}_${curriculumGrade.value.toLowerCase()}')
            .doc(
                "${sectionName.toLowerCase()}_${curriculumGrade.value.toString().toLowerCase()}")
            .get();
        final subjectData = subjectSectionUnits.data() as Map<String, dynamic>;
        final units = subjectData['units'];

        for (var unit in units) {
          allSectionUnits.add(unit as Map<String, dynamic>);
        }
      }
      name.value = id.value;
      _examController.units = allSectionUnits;
      _examController.examName.value = name.value;
      _examController.examType.value = "FinalExam";
      _examController.setExamQuestions();
      Get.to(() => const PreExam());
    } else {
      changeSelectedSectionIndex(subjectIndex);
      subjectNameFetcher(subjectIndex);

      final DocumentSnapshot<Map<String, dynamic>> subjectSectionUnits = await _db
          .collection(
              'subjects_${curriculumDepartment.toString().toLowerCase()}_${curriculumGrade.value.toLowerCase()}')
          .doc(
              "${name.value.toLowerCase()}_${curriculumGrade.value.toString().toLowerCase()}")
          .get();
      final subjectData = subjectSectionUnits.data() as Map<String, dynamic>;
      final units = subjectData['units'];
      _examController.units = units;
      _examController.examName.value = name.value;
      _examController.examType.value = "FinalExam";
      _examController.setExamQuestions();
      Get.to(() => const PreExam());
    }
  }

  void changeCurriculumGrade(String grade) {
    curriculumGrade.value = grade;
    _examController.examGrade.value = curriculumGrade.value;
    loadSubjects();
  }

  void changeCurriculumDepartment(String department) {
    curriculumDepartment.value = department;
    _examController.examDepartment.value = curriculumDepartment.value;
  }
}
