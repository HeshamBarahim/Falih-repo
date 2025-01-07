import 'package:falih/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectsController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for the selected item
  var name = "".obs;
  var id = "".obs;
  late LinearGradient color;
  late String iconPath;

  // Function to change the selected index
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void changeSelectedSectionIndex(int index) {
    selectedSectionIndex.value = index;
  }

  void loadSubjects() {
    if (userController.user.value?.selectedGrade == "12") {
      subjects.assignAll([
        {
          'name': S.current.subject_one,
          'color': AppColors.quranColor,
          'icon': Images.quranIcon,
        },
        {
          'name': S.current.subject_two,
          'color': AppColors.islamicColor,
          'icon': Images.islamicIcon
        },
        {
          'name': S.current.subject_three,
          'color': AppColors.arabicColor,
          'icon': Images.arabicIcon
        },
        {
          'name': S.current.subject_four,
          'color': AppColors.englisColor,
          'icon': Images.englishIcon
        },
        {
          'name': S.current.subject_five,
          'color': AppColors.chemistyColor,
          'icon': Images.chemistryIcon
        },
        {
          'name': S.current.subject_six,
          'color': AppColors.physicsColor,
          'icon': Images.physicsIcon
        },
        {
          'name': S.current.subject_seven,
          'color': AppColors.biologyColor,
          'icon': Images.biologyIcon
        },
        {
          'name': S.current.subject_eight,
          'color': AppColors.mathColor,
          'icon': Images.mathIcon
        },
      ]);
    } else if (userController.user.value?.selectedGrade == "9") {
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
          'name': "Science",
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
}
