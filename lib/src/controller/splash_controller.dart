import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize the animation controller and fading animation
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fadingAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController!);

    // Start the animation
    animationController!.repeat(reverse: true);
  }

  @override
  void onClose() {
    // Dispose the animation controller when the controller is closed
    animationController!.dispose();
    super.onClose();
  }
}
