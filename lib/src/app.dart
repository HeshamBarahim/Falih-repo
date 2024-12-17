import 'package:falih/src/config/themes.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/Auth/signup/signup.dart';
import 'package:falih/src/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = Get.find<AuthenticationRepository>();
    return Obx(() {
      // Check if auth check is complete
      if (!authRepo.isAuthCheckComplete.value) {
        return GetMaterialApp(
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
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: SplashScreen(),
        // Show loading screen while auth check is in progress

        initialRoute: "/splash",
        // Set the initial route
        unknownRoute: GetPage(name: '/signup', page: () => Signup()),

        getPages: [
          //  routes here
          // GetPage(
          //     name: '/',
          //     page: () =>
          //         hasSeenOnboarding ? Login() : const FirstPageBoarding()),
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

// cheack if the current state is arabic
bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
