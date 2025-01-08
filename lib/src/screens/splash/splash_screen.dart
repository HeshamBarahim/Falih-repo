import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/splash_controller.dart';
import '../../repository/authentication_repository/authentication_repository.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String sc_route = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // final SplashController splashController = Get.put(SplashController());
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
              onLoaded: (p0) {
                Future.delayed(p0.duration, () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomeScreen()),
                  // );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
