import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../../generated/l10n.dart';
import '../../curriculum/curriculum_page.dart';
import '../../home/home_page.dart';
import '../../leaderboard/leaderboard_screen.dart';
import '../utils/rive_utils.dart';

class NavBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ////////////
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  rive.SMIBool? isSideBarClosed;

  var bottomNavBarVisability = true.obs;
  var isSideNavBarClosed = true.obs;
  var lastBackPressTime;

  var selectedIndex = 1.obs;

  @override
  Future<void> onInit() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        update();
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void isOpen(rive.Artboard artboard) {
    var stateMachineController = RiveUtils.getRiveController(
      artboard,
      stateMachineName: "State Machine",
    );
    isSideBarClosed = stateMachineController.findSMI("isOpen") as rive.SMIBool?;
    isSideBarClosed?.value = true;
    update();
  }

  void onChangeIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  void showBottomNavBar() {
    bottomNavBarVisability.value = true;
    update();
  }

  void hideBottomNavBar() {
    bottomNavBarVisability.value = false;
    update();
  }

  void moveNavBar() {
    isSideBarClosed?.value = !isSideBarClosed!.value;
    if (isSideNavBarClosed.value) {
      animationController.forward();

      bottomNavBarVisability.value = false;
    } else {
      animationController.reverse();
      bottomNavBarVisability.value = true;
    }
    isSideNavBarClosed.value = isSideBarClosed!.value;
    update();
  }

  void closeNavBar() {
    isSideNavBarClosed.value = isSideBarClosed!.value;
    update();
  }


  final screens = [
    CurriculumPage(),
    HomePage(),
    LeaderBoardScreen(),
  ];
  final screenTitle = [
    S.current.subjects,
    S.current.home,
    S.current.leaderBoard
  ];
}
