import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../config/sizes.dart';

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth! * 0.7,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: GetBuilder<NavBarController>(
            init: NavBarController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth! * 0.02,
                      top: SizeConfig.screenHeight! * 0.02,
                    ),
                    child: const NavBarInfoCard(
                      name: "Amr Alsarori",
                      profession: "Software Engineer",
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
                      riveonInit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName: menu.stateMachineName);
                        menu.input = controller.findSMI("active") as SMIBool;
                      },
                      press: controller.isProsess
                          ? () => null
                          : () {
                              setState(() {
                                controller.isProsess = true;
                              });
                              menu.input!.change(true);
                              Future.delayed(const Duration(seconds: 1), () {
                                menu.input!.change(false);

                                if (menu.index == 1) {
                                  setState(() {
                                    controller.isProsess = false;
                                  });
                                } else if (menu.index == 2) {
                                  setState(() {
                                    controller.isProsess = false;
                                  });
                                } else if (menu.index == 3) {
                                  setState(() {
                                    controller.isProsess = false;
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
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName: menu.stateMachineName);
                        menu.input = controller.findSMI("active") as SMIBool;
                      },
                      press: controller.isProsess
                          ? () => null
                          : () {
                              setState(() {
                                controller.isProsess = true;
                              });
                              menu.input!.change(true);
                              Future.delayed(const Duration(seconds: 1), () {
                                menu.input!.change(false);

                                if (menu.index == 2) {
                                  setState(() {
                                    controller.isProsess = false;
                                  });
                                } else if (menu.index == 1) {
                                  setState(() {
                                    controller.isProsess = false;
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
