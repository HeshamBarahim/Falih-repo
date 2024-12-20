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
  late rive.SMIBool? isSideBarClosed;

  bool bottomNavBarVisability = true;
  bool isSideNavBarClosed = true;

  int selectedIndex = 1;
  ////////////
  @override
  Future<void> onInit() async {
    // TODO: implement onInit

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
    // user = await UserRepository.instance.getUserDetails();
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
    selectedIndex = index;
    update();
  }

  void showBottomNavBar() {
    bottomNavBarVisability = true;
    update();
  }

  void hideBottomNavBar() {
    bottomNavBarVisability = false;
    update();
  }

  void moveNavBar() {
    isSideBarClosed?.value = !isSideBarClosed!.value;
    if (isSideNavBarClosed) {
      animationController.forward();

      bottomNavBarVisability = false;
    } else {
      animationController.reverse();
      bottomNavBarVisability = true;
    }
    isSideNavBarClosed = isSideBarClosed!.value;
    update();
  }

  void closeNavBar() {
    isSideNavBarClosed = isSideBarClosed!.value;
    update();
  }

  void refresh() {
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
