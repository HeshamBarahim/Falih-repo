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
import '../../../controller/user_controller.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../controller/nav_bar_controller.dart';
import '../data/side_menu_data_list.dart';
import '../models/rive_asset.dart';
import '../utils/rive_utils.dart';
import 'nav_bar_info_card.dart';
import 'nav_bar_tile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  RiveAsset selectedMenu = sideMenuDataList_1.first;
  final UserController userController = Get.find<UserController>();

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
              // Color(0xFFfcf7fd),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: GetBuilder<NavBarController>(
            init: NavBarController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      // left: SizeConfig.screenWidth! * 0.00,
                      top: SizeConfig.screenHeight! * 0.02,
                    ),
                    child: NavBarInfoCard(
                      name: userController.user.value?.fullName ?? "user",
                      profession: userController.user.value?.schoolName ?? "",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth! * 0.06,
                      top: SizeConfig.screenHeight! * 0.045,
                      bottom: SizeConfig.screenHeight! * 0.02,
                    ),
                    child: Text(
                      "BROWSE",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                              setState(() {
                                controller.isProcess = true;
                              });
                              menu.input!.change(true);
                              Future.delayed(const Duration(seconds: 1), () {
                                menu.input!.change(false);

                                if (menu.index == 0) {
                                  setState(() {
                                    controller.isProcess = false;
                                    Get.offAll(const MenuScreen());
                                  });
                                } else if (menu.index == 1) {
                                  setState(() {
                                    controller.isProcess = false;
                                    Get.to(EditProfileScreen());
                                  });
                                } else if (menu.index == 2) {
                                  setState(() {
                                    controller.isProcess = false;
                                    Get.to(SubscriptionPlansScreen());
                                  });
                                } else if (menu.index == 3) {
                                  setState(() {
                                    controller.isProcess = false;
                                    Get.to(NotificationPage());
                                  });
                                }
                              });
                              setState(() {
                                selectedMenu = menu;
                              });
                            },
                      isActive: selectedMenu == menu,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth! * 0.06,
                      top: SizeConfig.screenHeight! * 0.045,
                      bottom: SizeConfig.screenHeight! * 0.02,
                    ),
                    child: Text(
                      "HISTORY",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white70,
                            fontSize: SizeConfig.screenHeight! * 0.018,
                          ),
                    ),
                  ),
                  ...sideMenuDataList_2.map(
                    (menu) => NavBarTile(
                      menu: menu,
                      riveonInit: (artboard) {
                        rive.StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName: menu.stateMachineName);
                        menu.input =
                            controller.findSMI("active") as rive.SMIBool;
                      },
                      press: controller.isProcess
                          ? () => null
                          : () {
                              setState(() {
                                controller.isProcess = true;
                              });
                              menu.input!.change(true);
                              Future.delayed(const Duration(seconds: 1), () {
                                menu.input!.change(false);

                                if (menu.index == 0) {
                                  setState(() {
                                    controller.isProcess = false;
                                    //
                                  });
                                } else if (menu.index == 1) {
                                  setState(() {
                                    controller.isProcess = false;
                                    Get.to(AboutUsScreen());
                                  });
                                } else if (menu.index == 2) {
                                  setState(() {
                                    controller.isProcess = false;
                                    Get.to(SettingsScreen());
                                  });
                                } else if (menu.index == 3) {
                                  setState(() {
                                    controller.isProcess = false;
                                    // Get.to(SettingsScreen());
                                    AuthenticationRepository.instance.logout();
                                  });
                                }
                              });
                              setState(() {
                                selectedMenu = menu;
                              });
                            },
                      isActive: selectedMenu == menu,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
