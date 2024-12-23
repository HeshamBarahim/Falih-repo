import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../../generated/l10n.dart';
import '../../curriculum/curriculum_page.dart';
import '../../home/home_page.dart';
import '../../leaderboard/leaderboard_screen.dart';
import '../data/side_menu_data_list.dart';
import '../models/rive_asset.dart';
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

  RiveAsset selectedMenu = sideMenuDataList_1.first;

  bool isProcess = false;

  int selectedIndex = 1;

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

  void changeCurrentPage(int index) {
    selectedIndex = index;
    update();
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

  void selectMenu(RiveAsset menu) {
    selectedMenu = menu;
    update();
  }

  void startProcess() {
    isProcess = true;
    update();
  }

  void stopProcess() {
    isProcess = false;
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
