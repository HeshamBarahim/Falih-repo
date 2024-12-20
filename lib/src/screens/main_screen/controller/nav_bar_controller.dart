import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

class NavBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  late rive.SMIBool isSideBarClosed;
  bool isSideNavBarClosed = true;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        update();
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.onInit();
    // user = await UserRepository.instance.getUserDetails();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
