import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String route = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: LottieBuilder.asset(
              'assets/splash_animation/splash_View.json',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
