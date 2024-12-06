import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/main_screen/menu_screen.dart';
import 'package:falih/src/screens/on_boarding/first_page_boarding.dart';
import 'package:falih/src/screens/pre_exam/pre_exam.dart';
import 'package:falih/src/screens/run_exam/run_exam.dart';
import 'package:falih/src/screens/subscription/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';
import 'screens/Auth/login/login.dart';
import 'screens/Auth/signup/signup.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize GetStorage instance
    final box = GetStorage();

    // Check if onboarding has been seen
    final hasSeenOnboarding = box.read('hasSeenOnboarding') ?? false;

    return GetMaterialApp(
      //  GetMaterialApp instead of MaterialApp
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
      getPages: [
        //  routes here
        // GetPage(
        //     name: '/',
        //     page: () =>
        //         hasSeenOnboarding ? Login() : const FirstPageBoarding()),
        GetPage(name: '/', page: () => Signup()),
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
  }
}

// cheack if the current state is arabic
bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
