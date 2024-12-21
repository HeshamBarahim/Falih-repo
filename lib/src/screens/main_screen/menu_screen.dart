// menu_screen_2
import 'dart:math';

import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/images.dart';
import '../../config/sizes.dart';
import '../../config/themes.dart';
import '../notification/notification_page.dart';
import 'components/nav_bar.dart';
import 'components/nav_bar_button.dart';
import 'controller/bottom_navigation_bar_controller.dart';
import 'controller/nav_bar_controller.dart';
import 'utils/rive_utils.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  DateTime? lastBackPressTime;

  final BottomNavBarController bottomNavBarController =
      BottomNavBarController();

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(NavigationController());
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
          lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.04,
                vertical: SizeConfig.screenHeight! * 0.01,
              ),
              content: Text(
                'Press back again to exit The App',
                style: TextStyle(
                  fontSize: SizeConfig.screenHeight! * 0.015,
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
      child: GetBuilder<NavBarController>(
        init: NavBarController(),
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF742f88),
                  Color(0xFF943dae),
                  Color(0xFFab59c5),
                  Color(0xFFbe7ed2),
                  Color(0xFFd1a4df),
                  Color(0xFFe4caed),
                  Color(0xFFf7effa),
                  Color(0xFFfcf7fd),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  width: SizeConfig.screenWidth! * 0.7,
                  left: controller.isSideNavBarClosed
                      ? -SizeConfig.screenWidth! * 0.7
                      : 0,
                  height: SizeConfig.screenHeight!,
                  child: NavBar(),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(controller.animation.value -
                        30 * controller.animation.value * pi / 180),
                  child: Transform.translate(
                    offset: Offset(
                        controller.animation.value *
                            SizeConfig.screenWidth! *
                            0.62,
                        0),
                    child: Transform.scale(
                      scale: controller.scalAnimation.value,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image:
                                      AssetImage(Images.backgroundImageOfAuth),
                                  fit: BoxFit.cover,
                                  opacity: 0.2,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight! * 0.053),
                            child: Container(
                              height: SizeConfig.screenHeight! * 0.067,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth! * 0.02),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.9,
                                    offset: Offset(0.9, 0.5),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: SizeConfig.screenWidth! * 0.12),
                                  Center(
                                    child: Obx(
                                      () => Text(
                                        bottomNavBarController.screenTitle[
                                            bottomNavBarController
                                                .selectedIndex.value],
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize:
                                              SizeConfig.screenHeight! * 0.032,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => NotificationPage());
                                    },
                                    icon: Icon(
                                      Icons.notifications,
                                      color: AppColors.mainColor,
                                      size: SizeConfig.screenHeight! * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight! * 0.12),
                            child: Obx(() => bottomNavBarController.screens[
                                bottomNavBarController.selectedIndex.value]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  left: controller.isSideNavBarClosed
                      ? 0
                      : SizeConfig.screenWidth! *
                          0.54, // top: SizeConfig.screenHeight! * 0.06,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight! * 0.053),
                    child: NavBarButton(
                      riveOnInit: (artboard) {
                        controller.onPressriveOnInit(artboard);
                      },
                      press: () {
                        controller.onPressNavBarButton();
                        /////////////////////////

                        controller.onOpen();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: controller.bottomNavBarVisability
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth! * 0.17),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(5, 9),
                        ),
                      ],
                    ),
                    child: Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth! * 0.07),
                        child: NavigationBarTheme(
                          data: NavigationBarThemeData(
                            indicatorColor: AppColors.choicesColor,
                            backgroundColor: AppColors.moreLightenMainColor,
                            labelTextStyle:
                                MaterialStateProperty.resolveWith<TextStyle>(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return TextStyle(
                                    fontSize: SizeConfig.screenWidth! *
                                        0.029, // Font size for selected labels
                                    fontWeight: FontWeight.bold,
                                    color: AppColors
                                        .mainColor, // Selected label color
                                  );
                                }
                                return TextStyle(
                                  fontSize:
                                      0, // Font size for unselected labels
                                  color: const Color(
                                      0xFFD2A8DF), // Unselected label color
                                );
                              },
                            ),
                          ),
                          child: NavigationBar(
                            elevation: 0,
                            selectedIndex:
                                bottomNavBarController.selectedIndex.value,
                            onDestinationSelected: (index) =>
                                bottomNavBarController.selectedIndex.value =
                                    index,
                            destinations: [
                              NavigationDestination(
                                selectedIcon: Icon(
                                  Icons.menu_book,
                                  color: AppColors.mainColor,
                                  size: SizeConfig.screenHeight! * 0.04,
                                ),
                                icon: Icon(
                                  Icons.menu_book_outlined,
                                  color: const Color(0xFFD2A8DF),
                                  size: SizeConfig.screenHeight! * 0.04,
                                ),
                                label: S.of(context).subjects,
                              ),
                              NavigationDestination(
                                selectedIcon: Icon(
                                  Icons.home,
                                  color: AppColors.mainColor,
                                  size: SizeConfig.screenHeight! * 0.04,
                                ),
                                icon: Icon(
                                  Icons.home,
                                  color: const Color(0xFFD2A8DF),
                                  size: SizeConfig.screenHeight! * 0.04,
                                ),
                                label: S.of(context).home,
                              ),
                              NavigationDestination(
                                selectedIcon: Icon(
                                  Icons.leaderboard_outlined,
                                  color: AppColors.mainColor,
                                  size: SizeConfig.screenHeight! * 0.04,
                                ),
                                icon: Icon(
                                  Icons.leaderboard_outlined,
                                  color: const Color(0xFFD2A8DF),
                                  size: SizeConfig.screenHeight! * 0.04,
                                ),
                                label: S.of(context).leaderBoard,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 1.obs;

//   final screens = [
//     CurriculumPage(),
//     HomePage(),
//     LeaderBoardScreen(),
//   ];
//   final screenTitle = [
//     S.current.subjects,
//     S.current.home,
//     S.current.leaderBoard
//   ];
// }
