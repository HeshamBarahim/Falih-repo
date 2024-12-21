import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../utils/rive_utils.dart';

class NavBarController extends GetxController with GetTickerProviderStateMixin {
  // late Rx<AnimationController> _animationController;
  late AnimationController _animationController;
  // late Rx<Animation<double>> animation;
  late Animation<double> animation;
  // late Rx<Animation<double>> scalAnimation;
  late Animation<double> scalAnimation;

  // late Rx<rive.SMIBool> isSideBarClosed;
  late rive.SMIBool isSideBarClosed;
  // RxBool isSideNavBarClosed = true.obs;
  bool isSideNavBarClosed = true;

  // RxBool bottomNavBarVisability = true.obs;
  bool bottomNavBarVisability = true;

  @override
  void onInit() {
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onPressriveOnInit(rive.Artboard artboard) {
    rive.StateMachineController controller = RiveUtils.getRiveController(
        artboard,
        stateMachineName: "State Machine");
    isSideBarClosed = controller.findSMI("isOpen") as rive.SMIBool;
    isSideBarClosed.value = true;
  }

  void onPressNavBarButton() async {
    isSideBarClosed.value = !isSideBarClosed.value;
    if (isSideNavBarClosed) {
      _animationController.forward();
      bottomNavBarVisability = false;
      update();
    } else {
      _animationController.reverse();
      Future.delayed(Duration(milliseconds: 300), () async {
        bottomNavBarVisability = true;
        update();
      });
    }
  }

  void onOpen() {
    isSideNavBarClosed = isSideBarClosed.value;
    update();
  }

  

  // void onShowBottomNavBar() {
  //   bottomNavBarVisability = false;
  //   update();
  // }

  // void onHideBottomNavBar() {
  //   bottomNavBarVisability = true;
  //   update();
  // }
}
