import 'package:flutter/material.dart';
import 'screens/home/home_page.dart';
import 'screens/Auth/login/login.dart';
import 'screens/Auth/signup/signup.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // '/' : (context) => const Home(),
        "signup": (context) => const Signup(),
        "login": (context) => const Login(),
      },
      home: Signup(),
    );
  }
}
