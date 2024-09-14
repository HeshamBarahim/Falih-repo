import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';

class CurriculumController extends GetxController {
  var subjects = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // loads the subjects into the subjects list
    loadSubjects();
  }

  void loadSubjects() {
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
  }
}
