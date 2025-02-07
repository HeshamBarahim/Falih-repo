// menu_screen_2
import 'dart:math';

import 'package:falih/src/controller/back_press_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/images.dart';
import '../../config/sizes.dart';
import '../../config/themes.dart';
import '../notification/notification_page.dart';
import 'components/bottom_nav_bar.dart';
import 'components/nav_bar.dart';
import 'components/nav_bar_button.dart';
import 'controller/nav_bar_controller.dart';

final BackPressController backPressController = Get.put(BackPressController());

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  DateTime? lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // ignore: deprecated_member_use
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
                  child: const NavBar(),
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
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.9,
                                    offset: Offset(0.9, 0.5),
                                  ),
                                ],
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: SizeConfig.screenWidth! * 0.12),
                                    Center(
                                      child: Text(
                                        controller.screenTitle[
                                            controller.selectedIndex],
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize:
                                              SizeConfig.screenHeight! * 0.032,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => const NotificationPage());
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
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight! * 0.12),
                            child: controller.screens[controller.selectedIndex],
                          ),
                          controller.isSideNavBarClosed == false
                              ? MaterialButton(
                                  onPressed: () {
                                    controller.stopProcess();
                                    controller.changeCurrentPage(1);
                                    controller.onPressNavBarButton();
                                    controller.onOpen();
                                  },
                                  child: Container(
                                    height: SizeConfig.screenHeight!,
                                    width: SizeConfig.screenWidth!,
                                    color: Colors.transparent,
                                  ),
                                )
                              : SizedBox(),
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
                          0.60, // top: SizeConfig.screenHeight! * 0.06,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight! * 0.053),
                    child: NavBarButton(
                      riveOnInit: (artboard) {
                        controller.onPressriveOnInit(artboard);
                      },
                      press: () {
                        controller.onPressNavBarButton();
                        controller.onOpen();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: controller.bottomNavBarVisability
              ? BottomNavBar(
                  selectedIndex: controller.selectedIndex,
                  onDestinationSelected: (index) {
                    controller.changeCurrentPage(index!);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
