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
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  rive.SMIBool? isSideBarClosed;

  var bottomNavBarVisibility = true.obs;
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
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
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
    bottomNavBarVisibility.value = true;
    update();
  }

  void hideBottomNavBar() {
    bottomNavBarVisibility.value = false;
    update();
  }

  void moveNavBar() {
    isSideNavBarClosed.value = !isSideBarClosed!.value;

    if (isSideNavBarClosed.value) {
      animationController.forward();
      bottomNavBarVisibility.value = false;
    } else {
      animationController.reverse();

      Future.delayed(const Duration(milliseconds: 300), () {
        bottomNavBarVisibility.value = true;
      });
    }
    isSideBarClosed?.value = !isSideBarClosed!.value;
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
