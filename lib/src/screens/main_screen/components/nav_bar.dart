// navbar
import 'package:falih/src/screens/about_us/about_us_screen.dart';
import 'package:falih/src/screens/main_screen/menu_screen.dart';
import 'package:falih/src/screens/notification/notification_page.dart';
import 'package:falih/src/screens/profile/edit_profile_screen.dart';
import 'package:falih/src/screens/settings/settings_screen.dart';
import 'package:falih/src/screens/subscription_plans/subscription_plans_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../config/sizes.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../controller/nav_bar_tile_controller.dart';
import '../data/side_menu_data_list.dart';
import '../utils/rive_utils.dart';
import 'nav_bar_info_card.dart';
import 'nav_bar_tile.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
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
          child: GetBuilder<NavBarTileController>(
            init: NavBarTileController(),
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
                        "BROWSE",
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
                          rive.StateMachineController stateMachineController =
                              RiveUtils.getRiveController(artBoard,
                                  stateMachineName: menu.stateMachineName);
                          menu.input = stateMachineController.findSMI("active")
                              as rive.SMIBool;
                        },
                        press: controller.isProcess
                            ? () {}
                            : () {
                                controller.startProcess();
                                menu.input!.change(true);
                                Future.delayed(const Duration(seconds: 1), () {
                                  menu.input!.change(false);

                                  if (menu.index == 0) {
                                    controller.stopProcess();
                                    Get.offAll(MenuScreen());
                                  } else if (menu.index == 1) {
                                    controller.stopProcess();
                                    Get.to(EditProfileScreen());
                                  } else if (menu.index == 2) {
                                    controller.stopProcess();
                                    Get.to(SubscriptionPlansScreen());
                                  } else if (menu.index == 3) {
                                    controller.stopProcess();
                                    Get.to(NotificationPage());
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
                        "HISTORY",
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
                          menu.input = stateMachineController.findSMI("active")
                              as rive.SMIBool;
                        },
                        press: controller.isProcess
                            ? () => null
                            : () {
                                controller.startProcess();
                                menu.input!.change(true);
                                Future.delayed(const Duration(seconds: 1), () {
                                  menu.input!.change(false);

                                  if (menu.index == 0) {
                                    controller.stopProcess();
                                    // Get.to(ContactUsScreen());
                                  } else if (menu.index == 1) {
                                    controller.stopProcess();
                                    Get.to(AboutUsScreen());
                                  } else if (menu.index == 2) {
                                    controller.stopProcess();
                                    Get.to(SettingsScreen());
                                  } else if (menu.index == 3) {
                                    controller.stopProcess();
                                    // Get.to(SettingsScreen());
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
    );
  }
}
