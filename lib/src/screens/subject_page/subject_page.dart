import 'package:falih/generated/l10n.dart';
import 'package:falih/src/screens/subject_page/widgets/subjects_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/sizes.dart';
import '../../controller/subjects_controller.dart';

class SubjectPage extends StatelessWidget {
  SubjectPage({super.key});

  final SubjectsController subjectController = Get.put(SubjectsController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight! * 0.25,
            decoration: BoxDecoration(
              gradient: subjectController.color,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          getSectionDisplayName(
                            subjectController.name.value,
                          ),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Image.asset(
                        subjectController.iconPath,
                        height: SizeConfig.screenHeight! * 0.10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SubjectsLabels(),
        ],
      ),
    );
  }

  String getSectionDisplayName(String key) {
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
      case "math":
        return S.current.subject_eight;

      default:
        return key.capitalizeFirst ?? key;
    }
  }
}
