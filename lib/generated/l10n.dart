// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `مرحبا بك من جديد`
  String get title_login {
    return Intl.message(
      'مرحبا بك من جديد',
      name: 'title_login',
      desc: 'This is the Start of the login page',
      args: [],
    );
  }

  /// `البحث عن حسابك`
  String get search_for_account {
    return Intl.message(
      'البحث عن حسابك',
      name: 'search_for_account',
      desc: '',
      args: [],
    );
  }

  /// `تغيير كلمة المرور`
  String get change_password_text {
    return Intl.message(
      'تغيير كلمة المرور',
      name: 'change_password_text',
      desc: '',
      args: [],
    );
  }

  String get cancel {
    return Intl.message(
      'إلغاء',
      name: 'cancel',
      desc: 'Cancel button text',
      args: [],
    );
  }

  String get exit {
    return Intl.message(
      'خروج',
      name: 'exit',
      desc: 'Cancel button text',
      args: [],
    );
  }

  String get update {
    return Intl.message(
      'تحديث',
      name: 'Update',
      desc: '',
      args: [],
    );
  }

  String get new_update_available_text {
    return Intl.message(
      '',
      name: 'new_update_available_text',
      desc: '',
      args: [],
    );
  }

  String get new_update_available {
    return Intl.message(
      '',
      name: 'new_update_available',
      desc: '',
      args: [],
    );
  }

  String get exit_exam {
    return Intl.message(
      'خروج من الاختبار',
      name: 'exit_exam',
      desc: 'Cancel button text',
      args: [],
    );
  }

  String get exit_exam_warning {
    return Intl.message(
      "هل أنت متأكد من أنك تريد الخروج من الاختبار؟",
      name: 'exit_exam_warning',
      desc: 'Cancel button text',
      args: [],
    );
  }

  String get whatsapp_open_denied {
    return Intl.message(
      'تم رفض مغادرة التطبيق وفتح الواتساب.',
      name: 'whatsapp_open_denied',
      desc: 'Message shown when the user denies opening WhatsApp',
      args: [],
    );
  }

  String get whatsapp_leave_warning {
    return Intl.message(
      'أنت على وشك مغادرة التطبيق وفتح الواتساب. هل تريد المتابعة؟',
      name: 'whatsapp_leave_warning',
      desc: 'Warning message before leaving the app to open WhatsApp',
      args: [],
    );
  }

  /// `+967`
  String get hint_text_phone {
    return Intl.message(
      '+967',
      name: 'hint_text_phone',
      desc: '',
      args: [],
    );
  }

  // String get hint_text_phone2 {
  //   return Intl.message(
  //     'رقم الهاتف',
  //     name: 'hint_text_phone2',
  //     desc: '',
  //     args: [],
  //   );
  // }

  String get hint_text_username_or_phone {
    return Intl.message(
      'اسم المسنخدم او رقم الهاتف',
      name: 'hint_text_username_or_phone',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور`
  String get hint_text_password {
    return Intl.message(
      'كلمة المرور',
      name: 'hint_text_password',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد كلمة المرور`
  String get hint_text_password_confirm {
    return Intl.message(
      'تأكيد كلمة المرور',
      name: 'hint_text_confirm',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور الجديدة`
  String get hint_text_new_password {
    return Intl.message(
      'كلمة المرور الجديدة',
      name: 'hint_text_new_password',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد كلمة المرور الجديدة`
  String get hint_text_new_password_confirm {
    return Intl.message(
      'تأكيد كلمة المرور الجديدة',
      name: 'hint_text_new_password_confirm',
      desc: '',
      args: [],
    );
  }

  /// `نسيت كلمة المرور؟`
  String get forget_password {
    return Intl.message(
      'نسيت كلمة المرور؟',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول`
  String get login {
    return Intl.message(
      'تسجيل الدخول',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `لم تقم بالتسجيل بعد؟ `
  String get not_registerd {
    return Intl.message(
      'لم تقم بالتسجيل بعد؟ ',
      name: 'not_registerd',
      desc: '',
      args: [],
    );
  }

  /// ` إنشاء حساب`
  String get create_account {
    return Intl.message(
      ' إنشاء حساب',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  String get create_account_successfully {
    return Intl.message(
      'Account created successfully!',
      name: 'create_account_successfully',
      desc: '',
      args: [],
    );
  }

  /// `الخطوة 1 من 2`
  String get step1_of_2 {
    return Intl.message(
      'الخطوة 1 من 2',
      name: 'step1_of_2',
      desc: '',
      args: [],
    );
  }

  /// `الخطوة 2 من 2`
  String get step2_of_2 {
    return Intl.message(
      'الخطوة 2 من 2',
      name: 'step2_of_2',
      desc: '',
      args: [],
    );
  }

  /// `إنشاء حساب`
  String get title_signup {
    return Intl.message(
      'إنشاء حساب',
      name: 'title_signup',
      desc: 'This is the start of the sign up Page',
      args: [],
    );
  }

  /// `الاسم الكامل`
  String get hint_text_fullname {
    return Intl.message(
      'الاسم الكامل',
      name: 'hint_text_fullname',
      desc: '',
      args: [],
    );
  }

  /// `اسم المستخدم`
  String get hint_text_username {
    return Intl.message(
      'اسم المستخدم',
      name: 'hint_text_username',
      desc: '',
      args: [],
    );
  }

  /// `المحافظة`
  String get hint_text_Governorate {
    return Intl.message(
      'المحافظة',
      name: 'hint_text_Governorate',
      desc: '',
      args: [],
    );
  }

  /// `التالي`
  String get next {
    return Intl.message(
      'التالي',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `اسم المدرسة`
  String get hint_text_School {
    return Intl.message(
      'اسم المدرسة',
      name: 'hint_text_School',
      desc: '',
      args: [],
    );
  }

  /// `الصف`
  String get hint_text_Grade {
    return Intl.message(
      'الصف',
      name: 'hint_text_Grade',
      desc: '',
      args: [],
    );
  }

  /// `القسم`
  String get hint_text_department {
    return Intl.message(
      'القسم',
      name: 'hint_text_department',
      desc: '',
      args: [],
    );
  }

  /// `لديك حساب؟ `
  String get bottom_text_part1 {
    return Intl.message(
      'لديك حساب؟ ',
      name: 'bottom_text_part1',
      desc: '',
      args: [],
    );
  }

  /// ` تسجيل الدخول `
  String get bottom_text_part2 {
    return Intl.message(
      ' تسجيل الدخول ',
      name: 'bottom_text_part2',
      desc: '',
      args: [],
    );
  }

  /// `Sana'a`
  /// `صنعاء`
  String get drop_governorate_val1 {
    return Intl.message(
      'صنعاء',
      name: 'drop_governorate_val1',
      desc: '',
      args: [],
    );
  }

  /// `Taiz`
  /// `تعز`
  String get drop_governorate_val2 {
    return Intl.message(
      'تعز',
      name: 'drop_governorate_val2',
      desc: '',
      args: [],
    );
  }

  /// `Ibb`
  /// `إب`
  String get drop_governorate_val3 {
    return Intl.message(
      'إب',
      name: 'drop_governorate_val3',
      desc: '',
      args: [],
    );
  }

  /// `Al Hudaydah`
  /// `الحديدة`
  String get drop_governorate_val4 {
    return Intl.message(
      'الحديدة',
      name: 'drop_governorate_val4',
      desc: '',
      args: [],
    );
  }

  /// `Amran`
  /// `عمران`
  String get drop_governorate_val5 {
    return Intl.message(
      'عمران',
      name: 'drop_governorate_val5',
      desc: '',
      args: [],
    );
  }

  /// `Lahij`
  /// `لحج`
  String get drop_governorate_val6 {
    return Intl.message(
      'لحج',
      name: 'drop_governorate_val6',
      desc: '',
      args: [],
    );
  }

  /// `Dhamar`
  /// `ذمار`
  String get drop_governorate_val7 {
    return Intl.message(
      'ذمار',
      name: 'drop_governorate_val7',
      desc: '',
      args: [],
    );
  }

  /// `Raymah`
  /// `ريمة`
  String get drop_governorate_val8 {
    return Intl.message(
      'ريمة',
      name: 'drop_governorate_val8',
      desc: '',
      args: [],
    );
  }

  /// `Al Mahwit`
  /// `المحويت`
  String get drop_governorate_val9 {
    return Intl.message(
      'المحويت',
      name: 'drop_governorate_val9',
      desc: '',
      args: [],
    );
  }

  /// `Hajjah`
  /// `حجة`
  String get drop_governorate_val10 {
    return Intl.message(
      'حجة',
      name: 'drop_governorate_val10',
      desc: '',
      args: [],
    );
  }

  /// `Sa'dah`
  /// `صعدة`
  String get drop_governorate_val11 {
    return Intl.message(
      'صعدة',
      name: 'drop_governorate_val11',
      desc: '',
      args: [],
    );
  }

  /// `Al-Jawf`
  /// `الجوف`
  String get drop_governorate_val12 {
    return Intl.message(
      'الجوف',
      name: 'drop_governorate_val12',
      desc: '',
      args: [],
    );
  }

  /// `الصف التاسع`
  String get drop_grade_val1 {
    return Intl.message(
      'الصف التاسع',
      name: 'drop_grade_val1',
      desc: '',
      args: [],
    );
  }

  /// `الصف الثاني عشر`
  String get drop_grade_val2 {
    return Intl.message(
      'الصف الثاني عشر',
      name: 'drop_grade_val2',
      desc: '',
      args: [],
    );
  }

  /// `اللغة الإنجليزية`
  String get drop_depatment_val1 {
    return Intl.message(
      'اللغة الإنجليزية',
      name: 'drop_depatment_val1',
      desc: '',
      args: [],
    );
  }

  /// `ذكر`
  String get male {
    return Intl.message(
      'ذكر',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `أنثى`
  String get female {
    return Intl.message(
      'أنثى',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `اللغة العربية`
  String get drop_depatment_val2 {
    return Intl.message(
      'اللغة العربية',
      name: 'drop_depatment_val2',
      desc: '',
      args: [],
    );
  }

  /// `تقديم`
  String get submit {
    return Intl.message(
      'تقديم',
      name: 'submit',
      desc: 'This is start of verification page',
      args: [],
    );
  }

  /// `رمز التحقق`
  String get otp {
    return Intl.message(
      'رمز التحقق',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// `قمنا بإرسال رمز التحقق إلى رقم هاتفك`
  String get explaination_text {
    return Intl.message(
      'قمنا بإرسال رمز التحقق إلى رقم هاتفك',
      name: 'explaination_text',
      desc: '',
      args: [],
    );
  }

  /// `مرحبًا يوسف`
  String get first_header_home {
    return Intl.message(
      'مرحبًا يوسف',
      name: 'first_header_home',
      desc: 'This is the start of the home Page',
      args: [],
    );
  }

  /// `لم يتم `
  String get part_one_subHeader {
    return Intl.message(
      'لم يتم ',
      name: 'part_one_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `لم تقم بالخضوع`
  String get changing_subHeader {
    return Intl.message(
      'لم تقم بالخضوع',
      name: 'changing_subHeader',
      desc: '',
      args: [],
    );
  }

  /// ` لأي اختبار بعد`
  String get part_two_subHeader {
    return Intl.message(
      ' لأي اختبار بعد',
      name: 'part_two_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `0 نقطة`
  String get score {
    return Intl.message(
      '0 نقطة',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `الدوري الفضي`
  String get name_league {
    return Intl.message(
      'الدوري الفضي',
      name: 'name_league',
      desc: '',
      args: [],
    );
  }

  /// `تاريخ الاختبارات الخاص بك`
  String get history_heading {
    return Intl.message(
      'تاريخ الاختبارات الخاص بك',
      name: 'history_heading',
      desc: '',
      args: [],
    );
  }

  /// `لم تقم بخوض أي اختبارات بعد`
  String get not_taken_exams_home_page {
    return Intl.message(
      'لم تقم بخوض أي اختبارات بعد',
      name: 'not_taken_exams_home_page',
      desc: '',
      args: [],
    );
  }

  /// `القرآن الكريم`
  String get subject_one {
    return Intl.message(
      'القرآن الكريم',
      name: 'subject_one',
      desc: 'This is the start of the Curriculum Page',
      args: [],
    );
  }

  /// `التربية الإسلامية`
  String get subject_two {
    return Intl.message(
      'التربية الإسلامية',
      name: 'subject_two',
      desc: '',
      args: [],
    );
  }

  /// `اللغة العربية`
  String get subject_three {
    return Intl.message(
      'اللغة العربية',
      name: 'subject_three',
      desc: '',
      args: [],
    );
  }

  /// `اللغة الإنجليزية`
  String get subject_four {
    return Intl.message(
      'اللغة الإنجليزية',
      name: 'subject_four',
      desc: '',
      args: [],
    );
  }

  /// `الكيمياء`
  String get subject_five {
    return Intl.message(
      'الكيمياء',
      name: 'subject_five',
      desc: '',
      args: [],
    );
  }

  /// `الفيزياء`
  String get subject_six {
    return Intl.message(
      'الفيزياء',
      name: 'subject_six',
      desc: '',
      args: [],
    );
  }

  /// `الأحياء`
  String get subject_seven {
    return Intl.message(
      'الأحياء',
      name: 'subject_seven',
      desc: '',
      args: [],
    );
  }

  /// `الرياضيات`
  String get subject_eight {
    return Intl.message(
      'الرياضيات',
      name: 'subject_eight',
      desc: '',
      args: [],
    );
  }

  /// `لم تقم بخوض أي اختبار بعد. قم بخوض الاختبار للانضمام إلى لوحة القيادة والمنافسة مع الطلاب الآخرين`
  String get not_taken_exams {
    return Intl.message(
      'لم تقم بخوض أي اختبار بعد. قم بخوض الاختبار للانضمام إلى لوحة القيادة والمنافسة مع الطلاب الآخرين',
      name: 'not_taken_exams',
      desc: 'This the start of leaderborad page',
      args: [],
    );
  }

  /// `الإحصائيات`
  String get statistics {
    return Intl.message(
      'الإحصائيات',
      name: 'statistics',
      desc: 'This the start of subject page',
      args: [],
    );
  }

  /// `الفصول`
  String get chapters {
    return Intl.message(
      'الفصول',
      name: 'chapters',
      desc: '',
      args: [],
    );
  }

  /// `اختبر ال50 سؤال`
  String get exams {
    return Intl.message(
      'اختبر ال50 سؤال',
      name: 'exams',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد`
  String get confirm {
    return Intl.message(
      'تأكيد',
      name: 'confirm',
      desc: 'This the start of run exam',
      args: [],
    );
  }

  /// `النتائج`
  String get results {
    return Intl.message(
      'النتائج',
      name: 'results',
      desc: 'Test ',
      args: [],
    );
  }

  /// `اختبار تدريبي`
  String get practice_test {
    return Intl.message(
      'اختبار تدريبي',
      name: 'practice_test',
      desc: 'Test ',
      args: [],
    );
  }

  /// `سؤال`
  String get question {
    return Intl.message(
      'سؤال',
      name: 'question',
      desc: 'Test ',
      args: [],
    );
  }

  /// `أسئلة`
  String get questions {
    return Intl.message(
      'أسئلة',
      name: 'questions',
      desc: 'Test ',
      args: [],
    );
  }

  /// `متابعة`
  String get continueText {
    return Intl.message(
      'متابعة',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `اختبارات الوحدة`
  String get unit_exams {
    return Intl.message(
      'اختبارات الوحدة',
      name: 'unit_exams',
      desc: '',
      args: [],
    );
  }

  /// `صحيح`
  String get correct {
    return Intl.message(
      'صحيح',
      name: 'correct',
      desc: 'the start of after exam',
      args: [],
    );
  }

  /// `خاطئ`
  String get wrong {
    return Intl.message(
      'خاطئ',
      name: 'wrong',
      desc: '',
      args: [],
    );
  }

  /// `العودة إلى المواضيع`
  String get back_to_subjects {
    return Intl.message(
      'العودة إلى المواضيع',
      name: 'back_to_subjects',
      desc: '',
      args: [],
    );
  }

  /// `مراجعة إجاباتك`
  String get review_answer {
    return Intl.message(
      'مراجعة إجاباتك',
      name: 'review_answer',
      desc: '',
      args: [],
    );
  }

  String get review {
    return Intl.message(
      'مراجعة',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `تمكن من موادك الدراسية مع رفيقك الدراسي النهائي`
  String get explaination_on_boarding_1 {
    return Intl.message(
      'تمكن من موادك الدراسية مع رفيقك الدراسي النهائي',
      name: 'explaination_on_boarding_1',
      desc: 'The start of boarding screens',
      args: [],
    );
  }

  /// `مرحبًا في`
  String get welcome_to {
    return Intl.message(
      'مرحبًا في',
      name: 'welcome_to',
      desc: '',
      args: [],
    );
  }

  /// `فالح`
  String get falih {
    return Intl.message(
      'فالح',
      name: 'falih',
      desc: '',
      args: [],
    );
  }

  /// `تعلم`
  String get learn {
    return Intl.message(
      'تعلم',
      name: 'learn',
      desc: '',
      args: [],
    );
  }

  /// `خطوتك`
  String get your {
    return Intl.message(
      'خطوتك',
      name: 'your',
      desc: '',
      args: [],
    );
  }

  /// `طريقتك`
  String get way {
    return Intl.message(
      'طريقتك',
      name: 'way',
      desc: '',
      args: [],
    );
  }

  /// `جهز`
  String get equip {
    return Intl.message(
      'جهز',
      name: 'equip',
      desc: '',
      args: [],
    );
  }

  /// `نفسك`
  String get your_self {
    return Intl.message(
      'نفسك',
      name: 'your_self',
      desc: '',
      args: [],
    );
  }

  /// `مع`
  String get with_the {
    return Intl.message(
      'مع',
      name: 'with_the',
      desc: '',
      args: [],
    );
  }

  /// `أفضل الأدوات`
  String get best_tools {
    return Intl.message(
      'أفضل الأدوات',
      name: 'best_tools',
      desc: '',
      args: [],
    );
  }

  /// `سيتم حساب الوقت أثناء الاختبار`
  String get explaintion_number1 {
    return Intl.message(
      'سيتم حساب الوقت أثناء الاختبار',
      name: 'explaintion_number1',
      desc: 'Start of the pre exam screen',
      args: [],
    );
  }

  /// `يمكنك مواصلة الاختبار في أي وقت`
  String get explaintion_number2 {
    return Intl.message(
      'يمكنك مواصلة الاختبار في أي وقت',
      name: 'explaintion_number2',
      desc: '',
      args: [],
    );
  }

  /// `ابدأ الاختبار`
  String get start_exam {
    return Intl.message(
      'ابدأ الاختبار',
      name: 'start_exam',
      desc: '',
      args: [],
    );
  }

  /// `تم`
  String get done {
    return Intl.message(
      'تم',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `المواد`
  String get subjects {
    return Intl.message(
      'المواد',
      name: 'subjects',
      desc: 'Navigation_Menu folder',
      args: [],
    );
  }

  /// `الرئيسية`
  String get home {
    return Intl.message(
      'الرئيسية',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `لوحة الصدارة`
  String get leaderBoard {
    return Intl.message(
      'لوحة الصدارة',
      name: 'leaderBoard',
      desc: '',
      args: [],
    );
  }

  /// `الإشعارات`
  String get notification {
    return Intl.message(
      'الإشعارات',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `تحديث الملف الشخصي`
  String get update_profile {
    return Intl.message(
      'تحديث الملف الشخصي',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `الإعدادات`
  String get settings {
    return Intl.message(
      'الإعدادات',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد أسئلة للعرض`
  String get no_question {
    return Intl.message(
      'لا يوجد أسئلة للعرض',
      name: 'no_question',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن ترك كلمة المرور فارغة`
  String get no_password {
    return Intl.message(
      'لا يمكن ترك كلمة المرور فارغة',
      name: 'no_password',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل الدفع`
  String get check_details {
    return Intl.message(
      'تفاصيل الدفع',
      name: 'check_details',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل الخطة`
  String get plan_details {
    return Intl.message(
      'تفاصيل الخطة',
      name: 'plan_details',
      desc: '',
      args: [],
    );
  }

  /// `خطة`
  String get plan {
    return Intl.message(
      'خطة',
      name: 'plan',
      desc: '',
      args: [],
    );
  }

  /// `النوع:`
  String get type {
    return Intl.message(
      'النوع:',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم تحديد أي خطة`
  String get no_plan_selected {
    return Intl.message(
      'لم يتم تحديد أي خطة',
      name: 'no_plan_selected',
      desc: '',
      args: [],
    );
  }

  /// `الصف:`
  String get class_text {
    return Intl.message(
      'الصف:',
      name: 'class_text',
      desc: '',
      args: [],
    );
  }

  /// `القسم:`
  String get section {
    return Intl.message(
      'القسم:',
      name: 'section',
      desc: '',
      args: [],
    );
  }

  /// `ر.ي`
  String get ry {
    return Intl.message(
      'ر.ي',
      name: 'ry',
      desc: '',
      args: [],
    );
  }

  /// `المدة:`
  String get duration {
    return Intl.message(
      'المدة:',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `أيام`
  String get days {
    return Intl.message(
      'أيام',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `حد اختبار الوحدة:`
  String get unit_exam_limit {
    return Intl.message(
      'حد اختبار الوحدة:',
      name: 'unit_exam_limit',
      desc: '',
      args: [],
    );
  }

  /// `مرات`
  String get times {
    return Intl.message(
      'مرات',
      name: 'times',
      desc: '',
      args: [],
    );
  }

  /// `حد الاختبار النهائي:`
  String get final_exam_limit {
    return Intl.message(
      'حد الاختبار النهائي:',
      name: 'final_exam_limit',
      desc: '',
      args: [],
    );
  }

  /// `السعر:`
  String get price {
    return Intl.message(
      'السعر:',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `سوف نرسل تفاصيل الطلب إلى رقم هاتفك بعد إكمال الدفع بنجاح`
  String get we_will_send {
    return Intl.message(
      'سوف نرسل تفاصيل الطلب إلى رقم هاتفك بعد إكمال الدفع بنجاح',
      name: 'we_will_send',
      desc: '',
      args: [],
    );
  }

  /// `دفع للخطة`
  String get pay_for_plan {
    return Intl.message(
      'دفع للخطة',
      name: 'pay_for_plan',
      desc: '',
      args: [],
    );
  }

  /// `تم إكمال الدفع بنجاح`
  String get pay_completed {
    return Intl.message(
      'تم إكمال الدفع بنجاح',
      name: 'pay_completed',
      desc: '',
      args: [],
    );
  }

  /// `رقم الحساب`
  String get account_number {
    return Intl.message(
      'رقم الحساب',
      name: 'account_number',
      desc: '',
      args: [],
    );
  }

  /// `رقم بطاقة الكريمي`
  String get kurami_card {
    return Intl.message(
      'رقم بطاقة الكريمي',
      name: 'kurami_card',
      desc: '',
      args: [],
    );
  }

  /// `يرجى إدخال رقم الحساب`
  String get enter_account_number {
    return Intl.message(
      'يرجى إدخال رقم الحساب',
      name: 'enter_account_number',
      desc: '',
      args: [],
    );
  }

  /// `رقم المستخدم`
  String get account_holder_number {
    return Intl.message(
      'رقم المستخدم',
      name: 'account_holder_number',
      desc: '',
      args: [],
    );
  }

  /// `يرجى إدخال اسم حامل البطاقة`
  String get enter_holder_number {
    return Intl.message(
      'يرجى إدخال اسم حامل البطاقة',
      name: 'enter_holder_number',
      desc: '',
      args: [],
    );
  }

  /// `يرجى إدخال رقم البطاقة`
  String get enter_card_number {
    return Intl.message(
      'يرجى إدخال رقم البطاقة',
      name: 'enter_card_number',
      desc: '',
      args: [],
    );
  }

  /// `الكريمي`
  String get kuraimi {
    return Intl.message(
      'الكريمي',
      name: 'kuraimi',
      desc: '',
      args: [],
    );
  }

  /// `جيب`
  String get jaib {
    return Intl.message(
      'جيب',
      name: 'jaib',
      desc: '',
      args: [],
    );
  }

  /// `نقاط`
  String get points {
    return Intl.message(
      'نقاط',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `هذا الاختبار هو محاكاة للاختبار النهائي`
  String get exam_simulation {
    return Intl.message(
      'هذا الاختبار هو محاكاة للاختبار النهائي',
      name: 'exam_simulation',
      desc: '',
      args: [],
    );
  }

  /// `سيتم حساب الوقت أثناء الاختبار`
  String get time_will_counted {
    return Intl.message(
      'سيتم حساب الوقت أثناء الاختبار',
      name: 'time_will_counted',
      desc: '',
      args: [],
    );
  }

  /// `يمكنك مواصلة الاختبار في أي وقت`
  String get you_can_continue {
    return Intl.message(
      'يمكنك مواصلة الاختبار في أي وقت',
      name: 'you_can_continue',
      desc: '',
      args: [],
    );
  }

  /// `ابدأ خوض الاختبار`
  String get start_taking_exam {
    return Intl.message(
      'ابدأ خوض الاختبار',
      name: 'start_taking_exam',
      desc: '',
      args: [],
    );
  }

  /// `الحساب`
  String get account {
    return Intl.message(
      'الحساب',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `تعديل الملف الشخصي`
  String get edit_profile {
    return Intl.message(
      'تعديل الملف الشخصي',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `الخصوصية`
  String get privacy {
    return Intl.message(
      'الخصوصية',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `باقات الاشتراك`
  String get subscription_packages {
    return Intl.message(
      'باقات الاشتراك',
      name: 'subscription_packages',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الخروج`
  String get logout {
    return Intl.message(
      'تسجيل الخروج',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `التفضيلات`
  String get preferences {
    return Intl.message(
      'التفضيلات',
      name: 'preferences',
      desc: '',
      args: [],
    );
  }

  /// `وضع الظلام`
  String get dark_mode {
    return Intl.message(
      'وضع الظلام',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `اللغة`
  String get language {
    return Intl.message(
      'اللغة',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `من نحن`
  String get about_us {
    return Intl.message(
      'من نحن',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `سهل الاستخدام`
  String get easy_use {
    return Intl.message(
      'سهل الاستخدام',
      name: 'easy_use',
      desc: '',
      args: [],
    );
  }

  /// `مصمم خصيصًا للطلاب، يوفر فالح واجهة بسيطة تجعل التنقل سهلًا. ابحث عن كل ما تحتاجه بضغطة زر.`
  String get subTitle_easy {
    return Intl.message(
      'مصمم خصيصًا للطلاب، يوفر فالح واجهة بسيطة تجعل التنقل سهلًا. ابحث عن كل ما تحتاجه بضغطة زر.',
      name: 'subTitle_easy',
      desc: '',
      args: [],
    );
  }

  /// `موثوق`
  String get trusted {
    return Intl.message(
      'موثوق',
      name: 'trusted',
      desc: '',
      args: [],
    );
  }

  /// `انضم إلى مجتمع متزايد من المتعلمين الذين يعتمدون على فالح للحصول على إجابات دقيقة ومساعدة مدعومة بالذكاء الاصطناعي. نجاحك هو أولويتنا.`
  String get subTitle_trusted {
    return Intl.message(
      'انضم إلى مجتمع متزايد من المتعلمين الذين يعتمدون على فالح للحصول على إجابات دقيقة ومساعدة مدعومة بالذكاء الاصطناعي. نجاحك هو أولويتنا.',
      name: 'subTitle_trusted',
      desc: '',
      args: [],
    );
  }

  /// `الوصول السريع`
  String get quick_access {
    return Intl.message(
      'الوصول السريع',
      name: 'quick_access',
      desc: '',
      args: [],
    );
  }

  /// `مع فالح، لن تضطر للانتظار. احصل على إجابات فورية وتفسيرات شاملة لأسئلتك.`
  String get subTitle_quick {
    return Intl.message(
      'مع فالح، لن تضطر للانتظار. احصل على إجابات فورية وتفسيرات شاملة لأسئلتك.',
      name: 'subTitle_quick',
      desc: '',
      args: [],
    );
  }

  /// `تنافس وتألق`
  String get compete_shine {
    return Intl.message(
      'تنافس وتألق',
      name: 'compete_shine',
      desc: '',
      args: [],
    );
  }

  /// `تحدى نفسك وارتقِ في لوحة المتصدرين! يجعل فالح التعلم ممتعًا مع المنافسة الودية، مما يساعدك على الحفاظ على حماسك وتحقيق المزيد.`
  String get subTitle_compete {
    return Intl.message(
      'تحدى نفسك وارتقِ في لوحة المتصدرين! يجعل فالح التعلم ممتعًا مع المنافسة الودية، مما يساعدك على الحفاظ على حماسك وتحقيق المزيد.',
      name: 'subTitle_compete',
      desc: '',
      args: [],
    );
  }

  /// `حقق أفضل ما لديك`
  String get achieve_your_best {
    return Intl.message(
      'حقق أفضل ما لديك',
      name: 'achieve_your_best',
      desc: '',
      args: [],
    );
  }

  /// `تجاوز حل الأسئلة. مع فالح، استكشف أدوات مدعومة بالذكاء الاصطناعي تعزز فهمك وتساعدك على التفوق في دراستك.`
  String get achieveTitle {
    return Intl.message(
      'تجاوز حل الأسئلة. مع فالح، استكشف أدوات مدعومة بالذكاء الاصطناعي تعزز فهمك وتساعدك على التفوق في دراستك.',
      name: 'achieveTitle',
      desc: '',
      args: [],
    );
  }

  /// `رحلتك مع فالح`
  String get your_journey {
    return Intl.message(
      'رحلتك مع فالح',
      name: 'your_journey',
      desc: '',
      args: [],
    );
  }

  /// `العودة إلى الصفحة الرئيسية`
  String get back_to_home {
    return Intl.message(
      'العودة إلى الصفحة الرئيسية',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `عودة`
  String get back {
    return Intl.message(
      'عودة',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `إغلاق`
  String get close {
    return Intl.message(
      'إغلاق',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `الشروط والأحكام`
  String get terms_conditions {
    return Intl.message(
      'الشروط والأحكام',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// ` و `
  String get and {
    return Intl.message(
      ' و ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `سياسة الخصوصية`
  String get privacy_policy {
    return Intl.message(
      'سياسة الخصوصية',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `بالنقر على 'إنشاء حساب'، فإنك توافق على `
  String get agreeing_message {
    return Intl.message(
      'بالنقر على \'إنشاء حساب\'، فإنك توافق على ',
      name: 'agreeing_message',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن أن يكون رقم الهاتف فارغًا`
  String get phone_cant_be_empty {
    return Intl.message(
      'لا يمكن أن يكون رقم الهاتف فارغًا',
      name: 'phone_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن أن تكون كلمة المرور فارغة`
  String get passwrod_cant_be_empty {
    return Intl.message(
      'لا يمكن أن تكون كلمة المرور فارغة',
      name: 'passwrod_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `يجب أن تكون كلمة المرور مكونة من 6 أحرف على الأقل`
  String get passwrod_must_be {
    return Intl.message(
      'يجب أن تكون كلمة المرور مكونة من 6 أحرف على الأقل',
      name: 'passwrod_must_be',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن أن يكون اسم المدرسة فارغًا`
  String get school_cant_be_empty {
    return Intl.message(
      'لا يمكن أن يكون اسم المدرسة فارغًا',
      name: 'school_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `يجب أن يكون اسم المدرسة صالحًا`
  String get school_must_be {
    return Intl.message(
      'يجب أن يكون اسم المدرسة صالحًا',
      name: 'school_must_be',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن أن يكون الاسم فارغًا`
  String get name_cant_be_empty {
    return Intl.message(
      'لا يمكن أن يكون الاسم فارغًا',
      name: 'name_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن أن يكون اسم المستخدم فارغًا`
  String get username_cant_be_empty {
    return Intl.message(
      'لا يمكن أن يكون اسم المستخدم فارغًا',
      name: 'username_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  String get username_already_exists {
    return Intl.message(
      'اسم المستخدم هذا موجود بالفعل',
      name: 'username_already_exists',
      desc:
          'Displayed when the user tries to register with an already taken username',
      args: [],
    );
  }

  String get phone_number_not_exists {
    return Intl.message(
      'رقم الهاتف هذا غير موجود',
      name: 'phone_number_not_exists',
      desc:
          'Displayed when the user tries to register with an already taken username',
      args: [],
    );
  }

  String get phone_number_exists {
    return Intl.message(
      '',
      name: 'phone_number_exists',
      desc:
          'Displayed when the user tries to register with an already taken phone number',
      args: [],
    );
  }

  String get username_too_short {
    return Intl.message(
      'يجب أن يكون اسم المستخدم أطول من 3 أحرف',
      name: 'username_too_short',
      desc: 'Validation message for short username',
      args: [],
    );
  }

  String get username_invalid_chars {
    return Intl.message(
      'يسمح فقط بالأحرف، الأرقام، و (_)، بدون رموز أخرى أو مسافات',
      name: 'username_invalid_chars',
      desc: 'Validation message for invalid characters in username',
      args: [],
    );
  }

  String get username_no_spaces {
    return Intl.message(
      'لا يُسمح بالمسافات في اسم المستخدم',
      name: 'username_no_spaces',
      desc: 'Validation message for username containing spaces',
      args: [],
    );
  }

  /// `يجب أن يكون اسم المستخدم صالحًا`
  String get name_must_be {
    return Intl.message(
      'يجب أن يكون اسم المستخدم صالحًا',
      name: 'name_must_be',
      desc: '',
      args: [],
    );
  }

  /// `يجب اختيار المحافظة`
  String get should_choose_governorate {
    return Intl.message(
      'يجب اختيار المحافظة',
      name: 'should_choose_governorate',
      desc: '',
      args: [],
    );
  }

  /// `يجب اختيار الصف الدراسي`
  String get should_choose_grade {
    return Intl.message(
      'يجب اختيار الصف الدراسي',
      name: 'should_choose_grade',
      desc: '',
      args: [],
    );
  }

  /// `يجب اختيار القسم`
  String get should_choose_department {
    return Intl.message(
      'يجب اختيار القسم',
      name: 'should_choose_department',
      desc: '',
      args: [],
    );
  }

  /// `يجب اختيار الجنس`
  String get should_choose_gender {
    return Intl.message(
      'يجب اختيار الجنس',
      name: 'should_choose_gender',
      desc: '',
      args: [],
    );
  }

  /// `تصفح`
  String get browse {
    return Intl.message(
      'تصفح',
      name: 'browse',
      desc: '',
      args: [],
    );
  }

  /// `السجل`
  String get history {
    return Intl.message(
      'السجل',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `الملف الشخصي`
  String get profile {
    return Intl.message(
      'الملف الشخصي',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `الاشتراك`
  String get Subscription {
    return Intl.message(
      'الاشتراك',
      name: 'Subscription',
      desc: '',
      args: [],
    );
  }

  /// `اتصل بنا`
  String get contact_us {
    return Intl.message(
      'اتصل بنا',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `مرحباً`
  String get hi {
    return Intl.message(
      'مرحباً',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `الترتيب`
  String get rank {
    return Intl.message(
      'الترتيب',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `إجمالي النقاط`
  String get over_all_points {
    return Intl.message(
      'إجمالي النقاط',
      name: 'over_all_points',
      desc: '',
      args: [],
    );
  }

  /// `نقاط هذا الشهر`
  String get this_month_points {
    return Intl.message(
      'نقاط هذا الشهر',
      name: 'this_month_points',
      desc: '',
      args: [],
    );
  }

  /// `آخر الامتحانات الخاصة بك`
  String get your_latest_exams {
    return Intl.message(
      'آخر الامتحانات الخاصة بك',
      name: 'your_latest_exams',
      desc: '',
      args: [],
    );
  }

  /// `ناجح`
  String get passed {
    return Intl.message(
      'ناجح',
      name: 'passed',
      desc: '',
      args: [],
    );
  }

  /// `راسب`
  String get failed {
    return Intl.message(
      'راسب',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `الإجابات الصحيحة`
  String get correct_answers {
    return Intl.message(
      'الإجابات الصحيحة',
      name: 'correct_answers',
      desc: '',
      args: [],
    );
  }

  /// `في`
  String get on {
    return Intl.message(
      'في',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `الصف`
  String get grade {
    return Intl.message(
      'الصف',
      name: 'grade',
      desc: '',
      args: [],
    );
  }

  /// `بيانات المستخدم غير متوفرة`
  String get user_data_not_available {
    return Intl.message(
      'بيانات المستخدم غير متوفرة',
      name: 'user_data_not_available',
      desc: '',
      args: [],
    );
  }

  /// `بيانات الدخول غير صحيحة. حاول مرة أخرى`
  String get wrong_credentials {
    return Intl.message(
      "بيانات الدخول غير صحيحة. حاول مرة أخرى.",
      name: 'wrong_credentials',
      desc: '',
      args: [],
    );
  }

  /// `اضغط مرة أخرى للخروج من التطبيق`
  String get press_back_again {
    return Intl.message(
      'اضغط مرة أخرى للخروج من التطبيق',
      name: 'press_back_again',
      desc: '',
      args: [],
    );
  }

  /// `أكمل عملية الدفع`
  String get check_out {
    return Intl.message(
      'أكمل عملية الدفع',
      name: 'check_out',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك اختيار المحافظة`
  String get u_should_choose_governorate {
    return Intl.message(
      'يجب عليك اختيار المحافظة',
      name: 'u_should_choose_governorate',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك اختيار الصف`
  String get u_should_choose_grade {
    return Intl.message(
      'يجب عليك اختيار الصف',
      name: 'u_should_choose_grade',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك اختيار القسم`
  String get u_should_choose_department {
    return Intl.message(
      'يجب عليك اختيار القسم',
      name: 'u_should_choose_department',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك اختيار النوع`
  String get u_should_choose_gender {
    return Intl.message(
      'يجب عليك اختيار النوع',
      name: 'u_should_choose_gender',
      desc: '',
      args: [],
    );
  }

  /// `اذهب واحصل على بعض الامتحانات`
  String get go_get_some_exams {
    return Intl.message(
      'اذهب واحصل على بعض الامتحانات',
      name: 'go_get_some_exams',
      desc: '',
      args: [],
    );
  }

  /// `القواعد والجوائز`
  String get rules_prizes {
    return Intl.message(
      'القواعد والجوائز',
      name: 'rules_prizes',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد امتحانات بعد، اذهب وخذ واحدًا`
  String get no_exams_yet {
    return Intl.message(
      'لا توجد امتحانات بعد، اذهب وخذ واحدًا',
      name: 'no_exams_yet',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد فصول حتى الآن`
  String get still_no_chapters {
    return Intl.message(
      'لا توجد فصول حتى الآن',
      name: 'still_no_chapters',
      desc: '',
      args: [],
    );
  }

  /// `إعادة إرسال الكود`
  String get resend_code {
    return Intl.message(
      'إعادة إرسال الكود',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد اتصال بالإنترنت`
  String get no_internet_connection {
    return Intl.message(
      'لا يوجد اتصال بالإنترنت',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `أنت غير متصل بالإنترنت.`
  String get u_are_disconnected_from_the_internet {
    return Intl.message(
      'أنت غير متصل بالإنترنت.',
      name: 'u_are_disconnected_from_the_internet',
      desc: '',
      args: [],
    );
  }

  /// `متصل بالإنترنت`
  String get connected_to_the_internet {
    return Intl.message(
      'متصل بالإنترنت',
      name: 'connected_to_the_internet',
      desc: '',
      args: [],
    );
  }

  String get loading_text {
    return Intl.message(
      '...جاري التحميل',
      name: 'loading_text',
      desc: '',
      args: [],
    );
  }

  String get logoutFromMoreThanOneDeviceTitle {
    return Intl.message(
      'تسجيل الخروج',
      name: 'logoutFromMoreThanOneDevice',
      desc: '',
      args: [],
    );
  }

  String get logoutFromMoreThanOneDevice {
    return Intl.message(
      'تم تسجيل خروجك لانك متصل بجهاز اخر',
      name: 'logoutFromMoreThanOneDevice',
      desc: '',
      args: [],
    );
  }

  /// `أنت الآن متصل بالإنترنت.`
  String get u_are_now_connected_to_internet {
    return Intl.message(
      'أنت الآن متصل بالإنترنت.',
      name: 'u_are_now_connected_to_internet',
      desc: '',
      args: [],
    );
  }

  /// `يرجى اختيار إجابة قبل المتابعة.`
  String get please_select_answer_before_proceeding {
    return Intl.message(
      'يرجى اختيار إجابة قبل المتابعة.',
      name: 'please_select_answer_before_proceeding',
      desc: '',
      args: [],
    );
  }

  /// `يرجى اختيار إجابة لاستخدام الذكاء الاصطناعي.`
  String get please_select_answer_to_use_ai {
    return Intl.message(
      'يرجى اختيار إجابة لاستخدام الذكاء الاصطناعي.',
      name: 'please_select_answer_to_use_ai',
      desc: '',
      args: [],
    );
  }

  /// `تم بنجاح`
  String get success {
    return Intl.message(
      'تم بنجاح',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `تم حفظ نتيجة الامتحان بنجاح!`
  String get exam_result_saved_successfully {
    return Intl.message(
      'تم حفظ نتيجة الامتحان بنجاح!',
      name: 'exam_result_saved_successfully',
      desc: '',
      args: [],
    );
  }

  /// `خطأ`
  String get error {
    return Intl.message(
      'خطأ',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `فشل في حفظ نتيجة الامتحان:`
  String get failed_to_save_exam {
    return Intl.message(
      'فشل في حفظ نتيجة الامتحان:',
      name: 'failed_to_save_exam',
      desc: '',
      args: [],
    );
  }

  /// `التقط صورة`
  String get take_photo {
    return Intl.message(
      'التقط صورة',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم تحديد صورة`
  String get no_image_selected {
    return Intl.message(
      'لم يتم تحديد صورة',
      name: 'no_image_selected',
      desc: '',
      args: [],
    );
  }

  /// `فشل في رفع الصورة`
  String get failed_upload_image {
    return Intl.message(
      'فشل في رفع الصورة',
      name: 'failed_upload_image',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث صورة الملف الشخصي بنجاح!`
  String get profile_image_updated_successfully {
    return Intl.message(
      'تم تحديث صورة الملف الشخصي بنجاح!',
      name: 'profile_image_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `فشل التحديث`
  String get updated_failed {
    return Intl.message(
      'فشل التحديث',
      name: 'updated_failed',
      desc: '',
      args: [],
    );
  }

  /// `حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.`
  String get unexpected_error_occured {
    return Intl.message(
      'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
      name: 'unexpected_error_occured',
      desc: '',
      args: [],
    );
  }

  String get wait_process_error {
    return Intl.message(
      'انتظر حتى تكتمل العملية',
      name: 'wait_process_error',
      desc: '',
      args: [],
    );
  }

  String get passwords_doesnt_match {
    return Intl.message(
      'كلمات المرور غير متطابقة',
      name: 'passwords_doesnt_match',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث الملف الشخصي بنجاح!`
  String get profile_updated_successfully {
    return Intl.message(
      'تم تحديث الملف الشخصي بنجاح!',
      name: 'profile_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `رفع صورة`
  String get upload_image {
    return Intl.message(
      'رفع صورة',
      name: 'upload_image',
      desc: '',
      args: [],
    );
  }

  /// `10 أسئلة`
  String get questions_10 {
    return Intl.message(
      '10 أسئلة',
      name: 'questions_10',
      desc: '',
      args: [],
    );
  }

  /// `الفصل`
  String get chapter {
    return Intl.message(
      'الوحدة',
      name: 'chapter',
      desc: '',
      args: [],
    );
  }

  /// `الكل`
  String get all {
    return Intl.message(
      'الكل',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `بدون اسم`
  String get no_name {
    return Intl.message(
      'بدون اسم',
      name: 'no_name',
      desc: '',
      args: [],
    );
  }

  /// `علوم`
  String get science {
    return Intl.message(
      'علوم',
      name: 'science',
      desc: '',
      args: [],
    );
  }

  /// `اجتماعيات`
  String get subject_nine {
    return Intl.message(
      'اجتماعيات',
      name: 'subject_nine',
      desc: '',
      args: [],
    );
  }

  /// `إعادة الاختبار`
  String get restart {
    return Intl.message(
      'إعادة الاختبار',
      name: 'restart',
      desc: '',
      args: [],
    );
  }

  /// `ر.ي ل `
  String get ry_for {
    return Intl.message(
      'ر.ي ل ',
      name: 'ry_for',
      desc: '',
      args: [],
    );
  }

  /// `القسم العربي`
  String get arabic_section {
    return Intl.message(
      'القسم العربي',
      name: 'arabic_section',
      desc: '',
      args: [],
    );
  }

  /// `القسم الإنجليزي`
  String get english_section {
    return Intl.message(
      'القسم الإنجليزي',
      name: 'english_section',
      desc: '',
      args: [],
    );
  }

  /// `الاختبارات النهائية`
  String get final_exams {
    return Intl.message(
      'الاختبارات النهائية',
      name: 'final_exams',
      desc: '',
      args: [],
    );
  }

  /// ` من خلال الاشتراك، فإنك توافق على`
  String get by_placing_this {
    return Intl.message(
      'من خلال الاشتراك، فإنك توافق على ',
      name: 'by_placing_this',
      desc: '',
      args: [],
    );
  }

  /// ` سيتم إعلامك قبل انتهاء فترة اشتراكك لتجديد أو تحديث الاشتراك. \n`
  String get subscription_automatically_renews {
    return Intl.message(
      ' سيتم إعلامك قبل انتهاء فترة اشتراكك لتجديد أو تحديث الاشتراك. \n',
      name: 'subscription_automatically_renews',
      desc: '',
      args: [],
    );
  }

  /// `احصل على الباقة المميزة`
  String get get_premium {
    return Intl.message(
      'احصل على الباقة المميزة',
      name: 'get_premium',
      desc: '',
      args: [],
    );
  }

  /// `افتح جميع إمكانيات فالح واستمتع\n`
  String get unlock_of_the_power {
    return Intl.message(
      'افتح جميع إمكانيات فالح واستمتع\n',
      name: 'unlock_of_the_power',
      desc: '',
      args: [],
    );
  }

  /// `بتجربة رقمية لم يسبق لها مثيل!`
  String get enjoy_digital_experience {
    return Intl.message(
      'بتجربة رقمية لم يسبق لها مثيل!',
      name: 'enjoy_digital_experience',
      desc: '',
      args: [],
    );
  }

  /// `خطة شهر واحد`
  String get month_plan_1 {
    return Intl.message(
      'خطة شهر واحد',
      name: 'month_plan_1',
      desc: '',
      args: [],
    );
  }

  /// `خطة شهرين`
  String get month_plan_2 {
    return Intl.message(
      'خطة شهرين',
      name: 'month_plan_2',
      desc: '',
      args: [],
    );
  }

  /// `خطة ثلاثة أشهر`
  String get month_plan_3 {
    return Intl.message(
      'خطة ثلاثة أشهر',
      name: 'month_plan_3',
      desc: '',
      args: [],
    );
  }

  /// `خطة الامتحانات المتقدمة`
  String get advanced_exam_plan {
    return Intl.message(
      'خطة الامتحانات المتقدمة',
      name: 'advanced_exam_plan',
      desc: '',
      args: [],
    );
  }

  /// `خطة الامتحانات الأساسية`
  String get basic_exam_plan {
    return Intl.message(
      'خطة الامتحانات الأساسية',
      name: 'basic_exam_plan',
      desc: '',
      args: [],
    );
  }

  /// `خطة الامتحانات القياسية`
  String get standard_exam_plan {
    return Intl.message(
      'خطة الامتحانات القياسية',
      name: 'standard_exam_plan',
      desc: '',
      args: [],
    );
  }

  /// `الامتحان النهائي`
  String get final_exam {
    return Intl.message(
      'الامتحان النهائي',
      name: 'final_exam',
      desc: '',
      args: [],
    );
  }

  /// `امتحان الوحدة`
  String get unit_exam {
    return Intl.message(
      'امتحان الوحدة',
      name: 'unit_exam',
      desc: '',
      args: [],
    );
  }

  /// `اختر أي قسم أو أختبر المنهج كامل`
  String get choose_any_section {
    return Intl.message(
      'اختر أي قسم أو أختبر المنهج كامل',
      name: 'choose_any_section',
      desc: '',
      args: [],
    );
  }

  /// `ثانية`
  String get second {
    return Intl.message(
      'ثانية',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم استلام كود التحقق`
  String get didnt_send_ver_code {
    return Intl.message(
      'لم يتم استلام كود التحقق',
      name: 'didnt_send_ver_code',
      desc: '',
      args: [],
    );
  }

  /// `اعادة ارسال كود التحقق`
  String get resend_ver_code {
    return Intl.message(
      'اعادة ارسال كود التحقق',
      name: 'resend_ver_code',
      desc: '',
      args: [],
    );
  }

  /// `تم التحقق من الكود بنجاح.`
  String get code_verified_successfully {
    return Intl.message(
      'تم التحقق من الكود بنجاح.',
      name: 'code_verified_successfully',
      desc: '',
      args: [],
    );
  }

  /// `رمز التحقق غير صالح. يرجى المحاولة مرة أخرى.`
  String get invalid_ver_code {
    return Intl.message(
      'رمز التحقق غير صالح. يرجى المحاولة مرة أخرى.',
      name: 'invalid_ver_code',
      desc: '',
      args: [],
    );
  }

  /// `فشل إرسال رمز التحقق. يرجى المحاولة مرة أخرى.`
  String get failed_send_ver_code {
    return Intl.message(
      'فشل إرسال رمز التحقق. يرجى المحاولة مرة أخرى.',
      name: 'failed_send_ver_code',
      desc: '',
      args: [],
    );
  }

  /// `فشل إرسال رمز التحقق. يرجى المحاولة مرة أخرى.`
  String get no_notification {
    return Intl.message(
      'لا يوجد إشعارات',
      name: 'no_notification',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
