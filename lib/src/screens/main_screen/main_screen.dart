import 'dart:math';

import 'package:falih/src/constants/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../config/sizes.dart';
import 'components/bottom_nav_bar.dart';
import 'components/nav_bar.dart';
import 'components/nav_bar_button.dart';
import 'controller/nav_bar_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastBackPressTime;
    SizeConfig().init(context);
    return PopScope(
      canPop: false, // Prevent default back navigation
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        DateTime now = DateTime.now();
        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
          lastBackPressTime = now;
          showInfoMessage(message: S.current.press_back_again);
        } else {
          // Allow pop if the back button is pressed again within 2 seconds
          Get.back();
        }
      },
      child: GetBuilder<NavBarController>(
        init: NavBarController(),
        builder: (controller) => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  controller.screenTitle[controller.selectedIndex],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Get.toNamed("notification");
                  },
                  icon: const Icon(
                    Icons.notifications,
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              extendBody: true,
              body: Transform(
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
                        controller.screens[controller.selectedIndex],
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
                            : const SizedBox(),
                      ],
                    ),
                  ),
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
            //// Drawer
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
            AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  left: controller.isSideNavBarClosed
                      ? 0
                      : SizeConfig.screenWidth! * 0.60,
              top: -50,
              child: Padding(
                padding: const EdgeInsets.only(top: 105),
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
    );
  }
}
