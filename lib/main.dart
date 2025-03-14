import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/settings_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:falih/src/screens/Auth/forgot_password/forgot_password.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/Auth/otp/otp_verification.dart';
import 'package:falih/src/screens/Auth/signup/signup.dart';
import 'package:falih/src/screens/about_us/about_us_screen.dart';
import 'package:falih/src/screens/checkout/checkout_screen.dart';
import 'package:falih/src/screens/exam/exam_screen.dart';
import 'package:falih/src/screens/main_screen/main_screen.dart';
import 'package:falih/src/screens/notification/notification_page.dart';
import 'package:falih/src/screens/on_boarding/first_page_boarding.dart';
import 'package:falih/src/screens/on_boarding/seconed_page_boarding.dart';
import 'package:falih/src/screens/on_boarding/third_page_boarding.dart';
import 'package:falih/src/screens/pre_exam/pre_exam.dart';
import 'package:falih/src/screens/profile/profile_screen.dart';
import 'package:falih/src/screens/results_screen/results_screen.dart';
import 'package:falih/src/screens/settings/settings_screen.dart';
import 'package:falih/src/screens/splash/splash_screen.dart';
import 'package:falih/src/screens/subject_page/subject_page.dart';
import 'package:falih/src/screens/subscription_plans/subscription_plans_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'src/controller/network_controller_real_time.dart';
import 'src/controller/notifications_controller.dart';
import 'src/controller/version_check_controller.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) {});
  await GetStorage.init();
  await initDependencies();
  runApp(MyApp());
}

Future<void> initDependencies() async {
  Get.put(NotificationsController());
  Get.put(NetworkControllerRealTime());
  Get.put(AuthenticationRepository());
  Get.put(UserRepository());
  Get.put(UserController());
  Get.put(SettingsController());
  // Get.put(VersionCheckController());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      darkTheme: darkAppTheme,
      themeMode: settingsController.themeMode.value,
      locale: Get.find<SettingsController>().locale.value,
      fallbackLocale: const Locale('ar'),
      initialRoute: '/splash',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const FirstPageBoarding()),
        GetPage(name: '/onboarding-2', page: () => const SecondPageBoarding()),
        GetPage(name: '/onboarding-3', page: () => const ThirdPageBoarding()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/otp-verification', page: () => OTPVerification()),
        GetPage(name: '/forgot-password', page: () => ForgotPassword()),
        GetPage(name: '/notification', page: () => const NotificationPage()),
        GetPage(name: '/main-screen', page: () => const MainScreen()),
        GetPage(name: '/subject-screen', page: () => SubjectPage()),
        GetPage(name: '/pre-exam', page: () => const PreExam()),
        GetPage(name: '/exam', page: () => const ExamScreen()),
        GetPage(name: '/results', page: () => const ResultsScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(
            name: '/subscription-plan', page: () => SubscriptionPlansScreen()),
        GetPage(name: '/about-us', page: () => AboutUsScreen()),
        GetPage(name: '/settings', page: () => const SettingsScreen()),
        GetPage(name: '/checkout', page: () => CheckoutScreen()),
      ],
    );
  }
}
