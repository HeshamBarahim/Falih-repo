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

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
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

  /// `Results`
  String get results {
    return Intl.message(
      'Results',
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

  /// `Questions`
  String get question {
    return Intl.message(
      'Questions',
      name: 'question',
      desc: 'Test ',
      args: [],
    );
  }

  /// `Questions`
  String get questions {
    return Intl.message(
      'Questions',
      name: 'questions',
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

  /// `Nontification`
  String get notification {
    return Intl.message(
      'Nontification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get update_profile {
    return Intl.message(
      'Update Profile',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `No questions to display`
  String get no_question {
    return Intl.message(
      'No questions to display',
      name: 'no_question',
      desc: '',
      args: [],
    );
  }

  /// `password cannot be empty`
  String get no_password {
    return Intl.message(
      'password cannot be empty',
      name: 'no_password',
      desc: '',
      args: [],
    );
  }

  /// `Checkout Details`
  String get check_details {
    return Intl.message(
      'Checkout Details',
      name: 'check_details',
      desc: '',
      args: [],
    );
  }

  /// `Plan Details`
  String get plan_details {
    return Intl.message(
      'Plan Details',
      name: 'plan_details',
      desc: '',
      args: [],
    );
  }

  /// `Plan`
  String get plan {
    return Intl.message(
      'Plan',
      name: 'plan',
      desc: '',
      args: [],
    );
  }

  /// `Type:`
  String get type {
    return Intl.message(
      'Type:',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `No Plan Selected`
  String get no_plan_selected {
    return Intl.message(
      'No Plan Selected',
      name: 'no_plan_selected',
      desc: '',
      args: [],
    );
  }

  /// `Class:`
  String get class_text {
    return Intl.message(
      'Class:',
      name: 'class_text',
      desc: '',
      args: [],
    );
  }

  /// `Section:`
  String get section {
    return Intl.message(
      'Section:',
      name: 'section',
      desc: '',
      args: [],
    );
  }

  /// `r.y`
  String get ry {
    return Intl.message(
      'r.y',
      name: 'ry',
      desc: '',
      args: [],
    );
  }

  /// `Duration:`
  String get duration {
    return Intl.message(
      'Duration:',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Unit Exam Limit:`
  String get unit_exam_limit {
    return Intl.message(
      'Unit Exam Limit:',
      name: 'unit_exam_limit',
      desc: '',
      args: [],
    );
  }

  /// `times`
  String get times {
    return Intl.message(
      'times',
      name: 'times',
      desc: '',
      args: [],
    );
  }

  /// `Final Exam Limit:`
  String get final_exam_limit {
    return Intl.message(
      'Final Exam Limit:',
      name: 'final_exam_limit',
      desc: '',
      args: [],
    );
  }

  /// `Price:`
  String get price {
    return Intl.message(
      'Price:',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `We will send you an order details to your email after the successful payment`
  String get we_will_send {
    return Intl.message(
      'We will send you an order details to your email after the successful payment',
      name: 'we_will_send',
      desc: '',
      args: [],
    );
  }

  /// `Pay For The Plan`
  String get pay_for_plan {
    return Intl.message(
      'Pay For The Plan',
      name: 'pay_for_plan',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successfully Completed`
  String get pay_completed {
    return Intl.message(
      'Payment Successfully Completed',
      name: 'pay_completed',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get account_number {
    return Intl.message(
      'Account Number',
      name: 'account_number',
      desc: '',
      args: [],
    );
  }

  /// `Kuraimi Card Number`
  String get kurami_card {
    return Intl.message(
      'Kuraimi Card Number',
      name: 'kurami_card',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Account Number`
  String get enter_account_number {
    return Intl.message(
      'Please Enter Your Account Number',
      name: 'enter_account_number',
      desc: '',
      args: [],
    );
  }

  /// `Holder Number`
  String get account_holder_number {
    return Intl.message(
      'Holder Number',
      name: 'account_holder_number',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter The Card Holder Name`
  String get enter_holder_number {
    return Intl.message(
      'Please Enter The Card Holder Name',
      name: 'enter_holder_number',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Card Number`
  String get enter_card_number {
    return Intl.message(
      'Please Enter Your Card Number',
      name: 'enter_card_number',
      desc: '',
      args: [],
    );
  }

  /// `Kuraimi`
  String get kuraimi {
    return Intl.message(
      'Kuraimi',
      name: 'kuraimi',
      desc: '',
      args: [],
    );
  }

  /// `Jaib`
  String get jaib {
    return Intl.message(
      'Jaib',
      name: 'jaib',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `This exam is a simulation of the final exam`
  String get exam_simulation {
    return Intl.message(
      'This exam is a simulation of the final exam',
      name: 'exam_simulation',
      desc: '',
      args: [],
    );
  }

  /// `Time will be counted during the exam`
  String get time_will_counted {
    return Intl.message(
      'Time will be counted during the exam',
      name: 'time_will_counted',
      desc: '',
      args: [],
    );
  }

  /// `You can continue to take the exam anytime`
  String get you_can_continue {
    return Intl.message(
      'You can continue to take the exam anytime',
      name: 'you_can_continue',
      desc: '',
      args: [],
    );
  }

  /// `Start taking the exam`
  String get start_taking_exam {
    return Intl.message(
      'Start taking the exam',
      name: 'start_taking_exam',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get edit_profile {
    return Intl.message(
      'Edit profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Subscription packages`
  String get subscription_packages {
    return Intl.message(
      'Subscription packages',
      name: 'subscription_packages',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message(
      'Preferences',
      name: 'preferences',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about_us {
    return Intl.message(
      'About us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Easy to Use`
  String get easy_use {
    return Intl.message(
      'Easy to Use',
      name: 'easy_use',
      desc: '',
      args: [],
    );
  }

  /// `Designed with students in mind, Falih offers an intuitive interface that makes navigation effortless. Find everything you need with just a few taps`
  String get subTitle_easy {
    return Intl.message(
      'Designed with students in mind, Falih offers an intuitive interface that makes navigation effortless. Find everything you need with just a few taps',
      name: 'subTitle_easy',
      desc: '',
      args: [],
    );
  }

  /// `Trusted`
  String get trusted {
    return Intl.message(
      'Trusted',
      name: 'trusted',
      desc: '',
      args: [],
    );
  }

  /// `Join a growing community of learners who rely on Falih for accurate answers and AI-powered assistance. Your success is our priority.`
  String get subTitle_trusted {
    return Intl.message(
      'Join a growing community of learners who rely on Falih for accurate answers and AI-powered assistance. Your success is our priority.',
      name: 'subTitle_trusted',
      desc: '',
      args: [],
    );
  }

  /// `Quick Access`
  String get quick_access {
    return Intl.message(
      'Quick Access',
      name: 'quick_access',
      desc: '',
      args: [],
    );
  }

  /// `With Falih, you don't have to wait. Get instant responses and comprehensive explanations to your questions.`
  String get subTitle_quick {
    return Intl.message(
      'With Falih, you don\'t have to wait. Get instant responses and comprehensive explanations to your questions.',
      name: 'subTitle_quick',
      desc: '',
      args: [],
    );
  }

  /// `Compete and Shine`
  String get compete_shine {
    return Intl.message(
      'Compete and Shine',
      name: 'compete_shine',
      desc: '',
      args: [],
    );
  }

  /// `Challenge yourself and climb the leaderboard! Falih makes learning exciting with friendly competition, helping you stay motivated and achieve more.`
  String get subTitle_compete {
    return Intl.message(
      'Challenge yourself and climb the leaderboard! Falih makes learning exciting with friendly competition, helping you stay motivated and achieve more.',
      name: 'subTitle_compete',
      desc: '',
      args: [],
    );
  }

  /// `Achieve Your Best`
  String get achieve_your_best {
    return Intl.message(
      'Achieve Your Best',
      name: 'achieve_your_best',
      desc: '',
      args: [],
    );
  }

  /// `Go beyond solving questions. With Falih, explore AI-driven tools that enhance your understanding and help you excel in your studies.`
  String get achieveTitle {
    return Intl.message(
      'Go beyond solving questions. With Falih, explore AI-driven tools that enhance your understanding and help you excel in your studies.',
      name: 'achieveTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Journey With Falih`
  String get your_journey {
    return Intl.message(
      'Your Journey With Falih',
      name: 'your_journey',
      desc: '',
      args: [],
    );
  }

  /// `Back To Home`
  String get back_to_home {
    return Intl.message(
      'Back To Home',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Terms && Conditions`
  String get terms_conditions {
    return Intl.message(
      'Terms && Conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get and {
    return Intl.message(
      ' and ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `By clicking on ‘Create Account,’ you’re agreeing to the app `
  String get agreeing_message {
    return Intl.message(
      'By clicking on ‘Create Account,’ you’re agreeing to the app ',
      name: 'agreeing_message',
      desc: '',
      args: [],
    );
  }

  /// `Phone Numbers cannot be empty`
  String get phone_cant_be_empty {
    return Intl.message(
      'Phone Numbers cannot be empty',
      name: 'phone_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password cannot be empty`
  String get passwrod_cant_be_empty {
    return Intl.message(
      'Password cannot be empty',
      name: 'passwrod_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password must be 6 characters at least`
  String get passwrod_must_be {
    return Intl.message(
      'Password must be 6 characters at least',
      name: 'passwrod_must_be',
      desc: '',
      args: [],
    );
  }

  /// `School Name cannot be empty`
  String get school_cant_be_empty {
    return Intl.message(
      'School Name cannot be empty',
      name: 'school_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `School Name must be valid`
  String get school_must_be {
    return Intl.message(
      'School Name must be valid',
      name: 'school_must_be',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get name_cant_be_empty {
    return Intl.message(
      'Name cannot be empty',
      name: 'name_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `User Name must be valid`
  String get name_must_be {
    return Intl.message(
      'User Name must be valid',
      name: 'name_must_be',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Governorate`
  String get should_choose_governorate {
    return Intl.message(
      'You should choose a Governorate',
      name: 'should_choose_governorate',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Grade`
  String get should_choose_grade {
    return Intl.message(
      'You should choose a Grade',
      name: 'should_choose_grade',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Department`
  String get should_choose_department {
    return Intl.message(
      'You should choose a Department',
      name: 'should_choose_department',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Gender`
  String get should_choose_gender {
    return Intl.message(
      'You should choose a Gender',
      name: 'should_choose_gender',
      desc: '',
      args: [],
    );
  }

  /// `Browse`
  String get browse {
    return Intl.message(
      'Browse',
      name: 'browse',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get Subscription {
    return Intl.message(
      'Subscription',
      name: 'Subscription',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message(
      'Contact Us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `hi`
  String get hi {
    return Intl.message(
      'hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Rank`
  String get rank {
    return Intl.message(
      'Rank',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `Overall points`
  String get over_all_points {
    return Intl.message(
      'Overall points',
      name: 'over_all_points',
      desc: '',
      args: [],
    );
  }

  /// `This month points`
  String get this_month_points {
    return Intl.message(
      'This month points',
      name: 'this_month_points',
      desc: '',
      args: [],
    );
  }

  /// `Your latest Exams`
  String get your_latest_exams {
    return Intl.message(
      'Your latest Exams',
      name: 'your_latest_exams',
      desc: '',
      args: [],
    );
  }

  /// `Passed`
  String get passed {
    return Intl.message(
      'Passed',
      name: 'passed',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Correct Answers`
  String get correct_answers {
    return Intl.message(
      'Correct Answers',
      name: 'correct_answers',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Class`
  String get grade {
    return Intl.message(
      'Class',
      name: 'grade',
      desc: '',
      args: [],
    );
  }

  /// `User data not available`
  String get user_data_not_available {
    return Intl.message(
      'User data not available',
      name: 'user_data_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Press back again to exit The App`
  String get press_back_again {
    return Intl.message(
      'Press back again to exit The App',
      name: 'press_back_again',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get check_out {
    return Intl.message(
      'Checkout',
      name: 'check_out',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Governorate`
  String get u_should_choose_governorate {
    return Intl.message(
      'You should choose a Governorate',
      name: 'u_should_choose_governorate',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Grade`
  String get u_should_choose_grade {
    return Intl.message(
      'You should choose a Grade',
      name: 'u_should_choose_grade',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Department`
  String get u_should_choose_department {
    return Intl.message(
      'You should choose a Department',
      name: 'u_should_choose_department',
      desc: '',
      args: [],
    );
  }

  /// `You should choose a Gender`
  String get u_should_choose_gender {
    return Intl.message(
      'You should choose a Gender',
      name: 'u_should_choose_gender',
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
