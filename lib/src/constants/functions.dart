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
