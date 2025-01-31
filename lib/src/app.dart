import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/settings_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = Get.find<AuthenticationRepository>();
    return Obx(() {
      // Check if auth check is complete
      if (!authRepo.isAuthCheckComplete.value) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home:
              SplashScreen(), // Show loading screen while auth check is in progress
        );
      }
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFFFFFFF),
          textTheme: GoogleFonts.montserratAlternatesTextTheme()
              .apply(bodyColor: AppColors.mainColor),
        ),
        // Bind locale from SettingsController
        locale: Get.find<SettingsController>().locale.value,
        fallbackLocale: const Locale('ar'),
        // Fallback to English
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const SplashScreen(),
        // Show loading screen while auth check is in progress

        initialRoute: "/splash",
        // Set the initial route
        unknownRoute: GetPage(name: '/signup', page: () => Login()),

        getPages: const [
          //  routes here
          // GetPage(
          //     name: '/',
          //     page: () =>
          //         hasSeenOnboarding ? Login() : const FirstPageBoarding()),
          // GetPage(name: 'MenuScreen.sc_route', page: () => MenuScreen()),
          // GetPage(name: '/signup', page: () => Signup()),
          // GetPage(name: '/', page: () => HomePage()),
          // GetPage(name: '/', page: () => CheckoutScreen()),
          // GetPage(name: '/', page: () => LeaderBoardScreen()),
          // GetPage(name: '/', page: () => const MenuScreen()),
          // GetPage(name: '/', page: () => Login()),
          // GetPage(name: '/', page: () => FirstPageBoarding()),
          // GetPage(name: '/', page: () => SubscriptionScreen()),
          // GetPage(name: '/login', page: () => Login()),
          // GetPage(name: '/runExam', page: () => const RunExam()),
          // GetPage(name: '/preExam', page: () => const PreExam()),
        ],
      );
    });
  }
}