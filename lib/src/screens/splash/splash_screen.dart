import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String route = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image_of_auth.png'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
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
