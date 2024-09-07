import 'package:falih/src/navigation_menu.dart';
import 'package:falih/src/screens/curriculum/curriculum.dart';
import 'package:falih/src/screens/leaderboard/leaderboard.dart';
import 'package:falih/src/screens/run_exam/run_exam.dart';
import 'package:flutter/material.dart';
import 'screens/Auth/login/login.dart';
import 'screens/Auth/signup/signup.dart';
import 'screens/home/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:falih/generated/l10n.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      routes: {
        // '/' : (context) => const Home(),
        "signup": (context) => const Signup(),
        "login": (context) => const Login(),
      },
      home: const NavigationMenu(),
    );
  }
}
