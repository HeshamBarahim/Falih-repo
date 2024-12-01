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

  /// `Welcome Back`
  String get title_login {
    return Intl.message(
      'Welcome Back',
      name: 'title_login',
      desc: 'This is the Start of the login page',
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

  /// `Password`
  String get hint_text_password {
    return Intl.message(
      'Password',
      name: 'hint_text_password',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forget_password {
    return Intl.message(
      'Forget Password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Not registerd yet? `
  String get not_registerd {
    return Intl.message(
      'Not registerd yet? ',
      name: 'not_registerd',
      desc: '',
      args: [],
    );
  }

  /// ` Create an Account`
  String get create_account {
    return Intl.message(
      ' Create an Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `step 1 of 2`
  String get step1_of_2 {
    return Intl.message(
      'step 1 of 2',
      name: 'step1_of_2',
      desc: '',
      args: [],
    );
  }

  /// `step 2 of 2`
  String get step2_of_2 {
    return Intl.message(
      'step 2 of 2',
      name: 'step2_of_2',
      desc: '',
      args: [],
    );
  }

  /// ` Create Account`
  String get title_signup {
    return Intl.message(
      ' Create Account',
      name: 'title_signup',
      desc: 'This is the start of the sign up Page',
      args: [],
    );
  }

  /// `Full Name`
  String get hint_text_username {
    return Intl.message(
      'Full Name',
      name: 'hint_text_username',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get hint_text_Governorate {
    return Intl.message(
      'Governorate',
      name: 'hint_text_Governorate',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `School Name`
  String get hint_text_School {
    return Intl.message(
      'School Name',
      name: 'hint_text_School',
      desc: '',
      args: [],
    );
  }

  /// `Grade`
  String get hint_text_Grade {
    return Intl.message(
      'Grade',
      name: 'hint_text_Grade',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get hint_text_department {
    return Intl.message(
      'Department',
      name: 'hint_text_department',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get hint_text_confirm {
    return Intl.message(
      'Confirm Password',
      name: 'hint_text_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Have an account? `
  String get bottom_text_part1 {
    return Intl.message(
      'Have an account? ',
      name: 'bottom_text_part1',
      desc: '',
      args: [],
    );
  }

  /// ` Login instead`
  String get bottom_text_part2 {
    return Intl.message(
      ' Login instead',
      name: 'bottom_text_part2',
      desc: '',
      args: [],
    );
  }

  /// `Sanaa`
  String get drop_governorate_val1 {
    return Intl.message(
      'Sanaa',
      name: 'drop_governorate_val1',
      desc: '',
      args: [],
    );
  }

  /// `Ibb`
  String get drop_governorate_val2 {
    return Intl.message(
      'Ibb',
      name: 'drop_governorate_val2',
      desc: '',
      args: [],
    );
  }

  /// `Taiz`
  String get drop_governorate_val3 {
    return Intl.message(
      'Taiz',
      name: 'drop_governorate_val3',
      desc: '',
      args: [],
    );
  }

  /// `class 9`
  String get drop_grade_val1 {
    return Intl.message(
      'class 9',
      name: 'drop_grade_val1',
      desc: '',
      args: [],
    );
  }

  /// `class 12`
  String get drop_grade_val2 {
    return Intl.message(
      'class 12',
      name: 'drop_grade_val2',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get drop_depatment_val1 {
    return Intl.message(
      'English',
      name: 'drop_depatment_val1',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get drop_depatment_val2 {
    return Intl.message(
      'Arabic',
      name: 'drop_depatment_val2',
      desc: '',
      args: [],
    );
  }

  /// `submit`
  String get submit {
    return Intl.message(
      'submit',
      name: 'submit',
      desc: 'This is start of verification page',
      args: [],
    );
  }

  /// `OTP`
  String get otp {
    return Intl.message(
      'OTP',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// `We have sent OTP code verification to your Phone Number`
  String get explaination_text {
    return Intl.message(
      'We have sent OTP code verification to your Phone Number',
      name: 'explaination_text',
      desc: '',
      args: [],
    );
  }

  /// `Resend The Code`
  String get resend_code {
    return Intl.message(
      'Resend The Code',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Hi Yousif,`
  String get first_header_home {
    return Intl.message(
      'Hi Yousif,',
      name: 'first_header_home',
      desc: 'This is the start of the home Page',
      args: [],
    );
  }

  /// `You have `
  String get part_one_subHeader {
    return Intl.message(
      'You have ',
      name: 'part_one_subHeader',
      desc: '',
      args: [],
    );
  }

  /// ` not taken `
  String get changing_subHeader {
    return Intl.message(
      ' not taken ',
      name: 'changing_subHeader',
      desc: '',
      args: [],
    );
  }

  /// ` any tests yet`
  String get part_two_subHeader {
    return Intl.message(
      ' any tests yet',
      name: 'part_two_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `0 points`
  String get score {
    return Intl.message(
      '0 points',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `Silvery League`
  String get name_league {
    return Intl.message(
      'Silvery League',
      name: 'name_league',
      desc: '',
      args: [],
    );
  }

  /// `Your test histroy`
  String get history_heading {
    return Intl.message(
      'Your test histroy',
      name: 'history_heading',
      desc: '',
      args: [],
    );
  }

  /// `You have not taken any tests yet`
  String get not_taken_exams_home_page {
    return Intl.message(
      'You have not taken any tests yet',
      name: 'not_taken_exams_home_page',
      desc: '',
      args: [],
    );
  }

  /// `Quran Kareem`
  String get subject_one {
    return Intl.message(
      'Quran Kareem',
      name: 'subject_one',
      desc: 'This is the start of the Curriculum Page',
      args: [],
    );
  }

  /// `Islamic Education`
  String get subject_two {
    return Intl.message(
      'Islamic Education',
      name: 'subject_two',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Language`
  String get subject_three {
    return Intl.message(
      'Arabic Language',
      name: 'subject_three',
      desc: '',
      args: [],
    );
  }

  /// `English Language`
  String get subject_four {
    return Intl.message(
      'English Language',
      name: 'subject_four',
      desc: '',
      args: [],
    );
  }

  /// `Chemistry`
  String get subject_five {
    return Intl.message(
      'Chemistry',
      name: 'subject_five',
      desc: '',
      args: [],
    );
  }

  /// `Physics`
  String get subject_six {
    return Intl.message(
      'Physics',
      name: 'subject_six',
      desc: '',
      args: [],
    );
  }

  /// `Biology`
  String get subject_seven {
    return Intl.message(
      'Biology',
      name: 'subject_seven',
      desc: '',
      args: [],
    );
  }

  /// `Math`
  String get subject_eight {
    return Intl.message(
      'Math',
      name: 'subject_eight',
      desc: '',
      args: [],
    );
  }

  /// `you have not taken any test yet take a test to join the leaderboard and compete with other students`
  String get not_taken_exams {
    return Intl.message(
      'you have not taken any test yet take a test to join the leaderboard and compete with other students',
      name: 'not_taken_exams',
      desc: 'This the start of leaderborad page',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: 'This the start of subject page',
      args: [],
    );
  }

  /// `Chapters`
  String get chapters {
    return Intl.message(
      'Chapters',
      name: 'chapters',
      desc: '',
      args: [],
    );
  }

  /// `Exams`
  String get exams {
    return Intl.message(
      'Exams',
      name: 'exams',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: 'This the start of run exam',
      args: [],
    );
  }

  /// `results`
  String get results {
    return Intl.message(
      'results',
      name: 'results',
      desc: 'Test ',
      args: [],
    );
  }

  /// `results`
  String get practice_test {
    return Intl.message(
      'results',
      name: 'practice_test',
      desc: 'Test ',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: 'Test ',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `unit_exams`
  String get unit_exams {
    return Intl.message(
      'unit_exams',
      name: 'unit_exams',
      desc: '',
      args: [],
    );
  }

  /// `Correct`
  String get correct {
    return Intl.message(
      'Correct',
      name: 'correct',
      desc: 'the start of after exam',
      args: [],
    );
  }

  /// `Wrong`
  String get wrong {
    return Intl.message(
      'Wrong',
      name: 'wrong',
      desc: '',
      args: [],
    );
  }

  /// `Back To Subjects`
  String get back_to_subjects {
    return Intl.message(
      'Back To Subjects',
      name: 'back_to_subjects',
      desc: '',
      args: [],
    );
  }

  /// `Review Your Answers`
  String get review_answer {
    return Intl.message(
      'Review Your Answers',
      name: 'review_answer',
      desc: '',
      args: [],
    );
  }

  /// `Master School Subjects with Your Ultimate Study Companion.`
  String get explaination_on_boarding_1 {
    return Intl.message(
      'Master School Subjects with Your Ultimate Study Companion.',
      name: 'explaination_on_boarding_1',
      desc: 'The start of boarding screens',
      args: [],
    );
  }

  /// `Welcome To`
  String get welcome_to {
    return Intl.message(
      'Welcome To',
      name: 'welcome_to',
      desc: '',
      args: [],
    );
  }

  /// `Falih`
  String get falih {
    return Intl.message(
      'Falih',
      name: 'falih',
      desc: '',
      args: [],
    );
  }

  /// `Learn`
  String get learn {
    return Intl.message(
      'Learn',
      name: 'learn',
      desc: '',
      args: [],
    );
  }

  /// `Your`
  String get your {
    return Intl.message(
      'Your',
      name: 'your',
      desc: '',
      args: [],
    );
  }

  /// `way`
  String get way {
    return Intl.message(
      'way',
      name: 'way',
      desc: '',
      args: [],
    );
  }

  /// `Equip`
  String get equip {
    return Intl.message(
      'Equip',
      name: 'equip',
      desc: '',
      args: [],
    );
  }

  /// `Yourself`
  String get your_self {
    return Intl.message(
      'Yourself',
      name: 'your_self',
      desc: '',
      args: [],
    );
  }

  /// `With The`
  String get with_the {
    return Intl.message(
      'With The',
      name: 'with_the',
      desc: '',
      args: [],
    );
  }

  /// `Best Tools`
  String get best_tools {
    return Intl.message(
      'Best Tools',
      name: 'best_tools',
      desc: '',
      args: [],
    );
  }

  /// `Time will be counted during the exam`
  String get explaintion_number1 {
    return Intl.message(
      'Time will be counted during the exam',
      name: 'explaintion_number1',
      desc: 'Start of the pre exam screen',
      args: [],
    );
  }

  /// `You can continue take exam anytime`
  String get explaintion_number2 {
    return Intl.message(
      'You can continue take exam anytime',
      name: 'explaintion_number2',
      desc: '',
      args: [],
    );
  }

  /// `Start Taking The Exam`
  String get start_exam {
    return Intl.message(
      'Start Taking The Exam',
      name: 'start_exam',
      desc: '',
      args: [],
    );
  }

  /// `done`
  String get done {
    return Intl.message(
      'done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Subjects`
  String get subjects {
    return Intl.message(
      'Subjects',
      name: 'subjects',
      desc: 'Navigation_Menu folder',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `LeaderBoard`
  String get leaderBoard {
    return Intl.message(
      'LeaderBoard',
      name: 'leaderBoard',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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
