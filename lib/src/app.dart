import 'package:falih/src/navigation_menu.dart';
import 'package:falih/src/screens/curriculum/curriculum.dart';
import 'package:falih/src/screens/home/home_page.dart';
import 'package:falih/src/screens/run_exam/run_exam.dart';
import 'package:flutter/material.dart';
import 'screens/Auth/login/login.dart';
import 'screens/Auth/signup/signup.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:falih/generated/l10n.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //  GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFFFFFFFF)),
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
        GetPage(name: '/', page: () => const NavigationMenu()),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/runExam', page: () => const RunExam()),
      ],
    );
  }
}
