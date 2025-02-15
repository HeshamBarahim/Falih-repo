import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/pre_exam/widgets_pre_exam/pre_exam_box.dart';
import 'package:falih/src/screens/run_exam/run_exam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/exam_controller.dart';
import '../../controller/subjects_controller.dart';

class PreExam extends StatelessWidget {
  const PreExam({super.key});

  @override
  Widget build(BuildContext context) {
    final ExamController controller = Get.find<ExamController>();
    final SubjectsController subjectController = Get.find<SubjectsController>();

    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          subjectController.changeSelectedIndex(0);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: subjectController.color),
            ),
            title: Text(
              getSectionDisplayName(subjectController.name.value),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(gradient: subjectController.color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              // box of the questions and points
              PreExamBox(questionCount: controller.questions.length),
              // box to set rules of the exam
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "القواعد:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.choicesColor, width: 5),
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "• ", // Bullet point
                                    style: TextStyle(
                                      fontSize: 30, // Increase bullet size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "يجب التأكد من اختيار إجابة قبل الانتقال للسؤال التالي.",
                                    // Your text
                                    style: TextStyle(
                                      fontSize: 18, // Regular text size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "• ", // Bullet point
                                    style: TextStyle(
                                      fontSize: 30, // Increase bullet size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "فالح، الاستاذ الذكي, سيتمكن من مساعدتك بعد اختيارك لإجابة.",
                                    // Your text
                                    style: TextStyle(
                                      fontSize: 18, // Regular text size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "• ", // Bullet point
                                    style: TextStyle(
                                      fontSize: 30, // Increase bullet size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "إذا تكرّر السؤال، فهذا يعني أنه ظهر في عدة اختبارات سنوية.",
                                    // Your text
                                    style: TextStyle(
                                      fontSize: 18, // Regular text size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "• ", // Bullet point
                                    style: TextStyle(
                                      fontSize: 30, // Increase bullet size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "إذا خرج الطالب من الاختبار دون إكماله، فلن يتم احتساب أي نقطة.",
                                    // Your text
                                    style: TextStyle(
                                      fontSize: 18, // Regular text size
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkMainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              // start taking the exam button
              GradientButton(
                text: S.of(context).start_taking_exam,
                height: 56,
                width: double.infinity,
                onClick: () {
                  controller.startTime = DateTime.now();
                  controller.startTimer();
                  Get.to(() => const RunExam());
                },
              ),
            ],
          ),
        ),
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
