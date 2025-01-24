// navbar
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/screens/about_us/about_us_screen.dart';
import 'package:falih/src/screens/profile/edit_profile_screen.dart';
import 'package:falih/src/screens/settings/settings_screen.dart';
import 'package:falih/src/screens/subscription_plans/subscription_plans_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../config/sizes.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../controller/nav_bar_controller.dart';
import '../data/side_menu_data_list.dart';
import '../utils/rive_utils.dart';
import 'nav_bar_info_card.dart';
import 'nav_bar_tile.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GetBuilder<NavBarController>(
        init: NavBarController(),
        builder: (controller) => Container(
          width: SizeConfig.screenWidth! * 0.7,
          height: double.infinity,
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
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: GetBuilder<NavBarController>(
              init: NavBarController(),
              builder: (controller) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth! * 0.03,
                          top: SizeConfig.screenHeight! * 0.01,
                        ),
                        child: NavBarInfoCard(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth! * 0.06,
                            vertical: SizeConfig.screenHeight! * 0.01),
                        child: Text(
                          S.of(context).browse,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: SizeConfig.screenHeight! * 0.018,
                          ),
                        ),
                      ),
                      ...sideMenuDataList_1.map(
                        (menu) => NavBarTile(
                          menu: menu,
                          riveonInit: (artBoard) {
                            rive.StateMachineController controller =
                                RiveUtils.getRiveController(artBoard,
                                    stateMachineName: menu.stateMachineName);
                            menu.input =
                                controller.findSMI("active") as rive.SMIBool;
                          },
                          press: controller.isProcess
                              ? () {}
                              : () {
                                  controller.startProcess();
                                  menu.input!.change(true);
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    menu.input!.change(false);

                                    if (menu.index == 0) {
                                      controller.stopProcess();
                                      controller.changeCurrentPage(1);
                                      controller.onPressNavBarButton();
                                      controller.onOpen();
                                    } else if (menu.index == 1) {
                                      controller.stopProcess();

                                      Get.to(() => EditProfileScreen());
                                    } else if (menu.index == 2) {
                                      controller.stopProcess();
                                      Get.to(() => SubscriptionPlansScreen());
                                    }
                                  });
                                  controller.selectMenu(menu);
                                },
                          isActive: controller.selectedMenu == menu,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth! * 0.06,
                          top: SizeConfig.screenHeight! * 0.03,
                          bottom: SizeConfig.screenHeight! * 0.01,
                        ),
                        child: Text(
                          S.of(context).history,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: SizeConfig.screenHeight! * 0.018,
                          ),
                        ),
                      ),
                      ...sideMenuDataList_2.map(
                        (menu) => NavBarTile(
                          menu: menu,
                          riveonInit: (artboard) {
                            rive.StateMachineController stateMachineController =
                                RiveUtils.getRiveController(artboard,
                                    stateMachineName: menu.stateMachineName);
                            menu.input = stateMachineController
                                .findSMI("active") as rive.SMIBool;
                          },
                          press: controller.isProcess
                              ? () => ()
                              : () {
                                  controller.startProcess();
                                  menu.input!.change(true);
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    menu.input!.change(false);

                                    // if (menu.index == 0) {
                                    //   controller.stopProcess();
                                    //   // Get.to(() => ContactUsScreen());
                                    // }
                                    if (menu.index == 0) {
                                      controller.stopProcess();
                                      Get.to(() => AboutUsScreen());
                                    } else if (menu.index == 1) {
                                      controller.stopProcess();
                                      // navController.moveNavBar();
                                      Get.to(() => const SettingsScreen());
                                    } else if (menu.index == 2) {
                                      controller.stopProcess();
                                      AuthenticationRepository.instance
                                          .logout(context);
                                    }
                                  });
                                  controller.selectMenu(menu);
                                },
                          isActive: controller.selectedMenu == menu,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
