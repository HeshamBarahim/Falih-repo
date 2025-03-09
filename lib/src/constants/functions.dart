import 'package:get/get.dart';

import '../../generated/l10n.dart';

bool isArabic(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text);
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

String getTypeExamDisplayName(String key) {
  // print("Plan ID from Firebase: $key");
  switch (key) {
    case "FinalExam":
      return S.current.final_exam;
    case "UnitExam":
      return S.current.unit_exam;

    default:
      return key.capitalizeFirst ?? key;
  }
}

String getCustomPlanName(String id) {
  switch (id) {
    case "1-MonthDurationPlan12Arabic":
      return S.current.month_plan_1;
    case "1-MonthDurationPlan12English":
      return S.current.month_plan_1;
    case "1-MonthDurationPlan9Arabic":
      return S.current.month_plan_1;
    case "1-MonthDurationPlan9English":
      return S.current.month_plan_1;
    case "2-MonthDurationPlan12Arabic":
      return S.current.month_plan_2;
    case "2-MonthDurationPlan12English":
      return S.current.month_plan_2;
    case "2-MonthDurationPlan9Arabic":
      return S.current.month_plan_2;
    case "2-MonthDurationPlan9English":
      return S.current.month_plan_2;
    case "3-MonthDurationPlan12Arabic":
      return S.current.month_plan_3;
    case "3-MonthDurationPlan12English":
      return S.current.month_plan_3;
    case "3-MonthDurationPlan9Arabic":
      return S.current.month_plan_3;
    case "3-MonthDurationPlan9English":
      return S.current.month_plan_3;
    case "AdvancedExamPlan12Arabic":
      return S.current.advanced_exam_plan;
    case "AdvancedExamPlan12English":
      return S.current.advanced_exam_plan;
    case "AdvancedExamPlan9Arabic":
      return S.current.advanced_exam_plan;
    case "AdvancedExamPlan9English":
      return S.current.advanced_exam_plan;
    case "BasicExamPlan12Arabic":
      return S.current.basic_exam_plan;
    case "BasicExamPlan12English":
      return S.current.basic_exam_plan;
    case "BasicExamPlan9Arabic":
      return S.current.basic_exam_plan;
    case "BasicExamPlan9English":
      return S.current.basic_exam_plan;
    case "StandardExamPlan12Arabic":
      return S.current.standard_exam_plan;
    case "StandardExamPlan12English":
      return S.current.standard_exam_plan;
    case "StandardExamPlan9Arabic":
      return S.current.standard_exam_plan;
    case "StandardExamPlan9English":
      return S.current.standard_exam_plan;

    default:
      return "Default Plan Name";
  }
}