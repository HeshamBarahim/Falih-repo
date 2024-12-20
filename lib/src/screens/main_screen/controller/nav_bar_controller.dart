import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../../generated/l10n.dart';
import '../../curriculum/curriculum_page.dart';
import '../../home/home_page.dart';
import '../../leaderboard/leaderboard_screen.dart';

class NavBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Rx<int> selectedIndex = 1.obs;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late rive.SMIBool isSideBarClosed;
  bool isSideNavBarClosed = true;

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
    // user = await UserRepository.instance.getUserDetails();
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
