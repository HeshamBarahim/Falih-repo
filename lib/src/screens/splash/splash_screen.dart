import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String scRoute = '/splash-screen';

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.put(SplashController());
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
            child: FadeTransition(
              opacity: splashController.fadingAnimation!,
              child: Image.asset(
                'assets/images/logo_falih.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
