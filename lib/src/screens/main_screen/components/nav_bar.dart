// navbar
import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:url_launcher/url_launcher.dart';

import '../../../config/sizes.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../controller/nav_bar_controller.dart';
import '../data/side_menu_data_list.dart';
import '../utils/rive_utils.dart';
import 'nav_bar_info_card.dart';
import 'nav_bar_tile.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  final String phoneNumber = "+967772020501"; // Your WhatsApp number

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final isRTL =
        Get.locale?.languageCode == "ar" ? TextAlign.right : TextAlign.left;
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
                Color(0xFFab59c5),
                Color(0xFFab59c5),
                Color(0xFFab59c5),
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
                        padding: const EdgeInsets.all(8),
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

                                      Get.toNamed("profile");
                                    } else if (menu.index == 2) {
                                      controller.stopProcess();
                                      Get.toNamed("subscription-plan");
                                    }
                                  });
                                  controller.selectMenu(menu);
                                },
                          isActive: controller.selectedMenu == menu,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
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

                                    if (menu.index == 0) {
                                      controller.stopProcess();
                                      // _openWhatsApp(context);
                                      showDialog(
                                        context: Get.context!,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              S.current.confirm,
                                              textAlign: isRTL,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Get.isDarkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                            ),
                                            content: Text(
                                              S.current.whatsapp_leave_warning,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Get.isDarkMode
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                              textAlign:
                                                  isRTL, // Align button text
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  final String url =
                                                      "https://wa.me/$phoneNumber";

                                                  final Uri uri =
                                                      Uri.parse(url);
                                                  await launchUrl(uri,
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                },
                                                // Stay in exam
                                                child: Text(
                                                  S.current.continueText,
                                                  textAlign: isRTL,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: Get.isDarkMode
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .secondary
                                                            : Theme.of(context)
                                                                .primaryColor,
                                                      ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context,
                                                      true); // Allow exit
                                                },
                                                child: Text(
                                                  S.current.cancel,
                                                  textAlign: isRTL,
                                                  // Align button text
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: Get.isDarkMode
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .secondary
                                                            : Theme.of(context)
                                                                .primaryColor,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else if (menu.index == 1) {
                                      controller.stopProcess();
                                      Get.toNamed("about-us");
                                    } else if (menu.index == 2) {
                                      controller.stopProcess();
                                      Get.toNamed("settings");
                                    } else if (menu.index == 3) {
                                      controller.stopProcess();
                                      AuthenticationRepository.instance
                                          .logout();
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
