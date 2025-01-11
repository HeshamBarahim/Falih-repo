import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/splash_controller.dart';
import '../../repository/authentication_repository/authentication_repository.dart';
import 'package:lottie/lottie.dart';

import '../Auth/login/login.dart';
import '../main_screen/main_screen.dart';
import '../on_boarding/first_page_boarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String sc_route = '/splash-screen';

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository auth = Get.put(AuthenticationRepository());
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
                  final user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    Get.offAll(() =>  MainScreen());
                  } else {
                    auth.userStorage.writeIfNull('isFirstTime', true);

                    bool isFirstTime =
                        auth.userStorage.read('isFirstTime') ?? true;
                    if (isFirstTime) {
                      Get.offAll(() => FirstPageBoarding());
                    } else {
                      Get.offAll(() => Login());
                    }
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
