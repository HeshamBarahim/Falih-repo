import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

import '../../config/sizes.dart';
import '../../config/themes.dart';
import '../curriculum/curriculum.dart';
import '../home/home_page.dart';
import '../leaderboard/leaderboard_screen.dart';
import '../profile/edit_profile_screen.dart';
import '../settings/settings_screen_2.dart';
import 'components/nav_bar_button.dart';
import 'components/nav_bar.dart';
import 'utils/rive_utils.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  late SMIBool isSideBarClosed;
  bool isSideNavBarClosed = true;
  DateTime? lastBackPressTime;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
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
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
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
              content: const Text('Press back again to exit'),
              duration: const Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.amber,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: SizeConfig.screenWidth! * 0.7,
              left: isSideNavBarClosed ? -SizeConfig.screenWidth! * 0.7 : 0,
              height: SizeConfig.screenHeight!,
              child: const NavBar(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset:
                    Offset(animation.value * SizeConfig.screenWidth! * 0.66, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: Scaffold(
                    body: Stack(
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 0.06,
                          width: SizeConfig.screenWidth!,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth! * 0.02,
                              vertical: SizeConfig.screenHeight! * 0.015),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBF7FC),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  onPressed: () {
                                    Get.to(() => EditProfileScreen());
                                  },
                                  icon: Icon(
                                    Icons.notifications_none,
                                    size: 25.w,
                                  ),
                                  color: AppColors.mainColor,
                                  iconSize: 25.w),
                              Center(
                                child: Obx(
                                  () => Text(
                                    controller.screenTitle[
                                        controller.selectedIndex.value],
                                    style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily:
                                            'GoogleFonts.montserratAlternatesTextTheme',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                  ),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.05),
                                onPressed: () {
                                  Get.to(() => const SettingsScreen_2());
                                },
                                icon: const Icon(Icons.settings),
                                color: AppColors.mainColor,
                                iconSize: 25.w,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight! * 0.08),
                          child: Scaffold(
                              bottomNavigationBar: Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.2), // Shadow color
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0,
                                            -3), // Positioning of the shadow (vertical)
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    child: NavigationBar(
                                        indicatorColor: AppColors.choicesColor,
                                        backgroundColor:
                                            AppColors.moreLigtenMainColor,
                                        height: 100.h,
                                        elevation: 0,
                                        selectedIndex:
                                            controller.selectedIndex.value,
                                        onDestinationSelected: (index) =>
                                            controller.selectedIndex.value =
                                                index,
                                        destinations: [
                                          NavigationDestination(
                                              icon: Icon(
                                                Icons.menu_book_outlined,
                                                color: AppColors.mainColor,
                                                size: 30.w,
                                              ),
                                              label: S.of(context).subjects),
                                          NavigationDestination(
                                            icon: Icon(
                                              Icons.home,
                                              color: AppColors.mainColor,
                                              size: 30.w,
                                            ),
                                            label: S.of(context).home,
                                          ),
                                          NavigationDestination(
                                            icon: Icon(
                                              Icons.leaderboard_outlined,
                                              color: AppColors.mainColor,
                                              size: 30.w,
                                            ),
                                            label: S.of(context).leaderBoard,
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              body: Obx(() => controller
                                  .screens[controller.selectedIndex.value])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.fastOutSlowIn,
              left: isSideNavBarClosed ? 0 : SizeConfig.screenWidth! * 0.54,
              top: SizeConfig.screenHeight! * 0.019,
              child: Row(
                children: [
                  NavBarButton(
                    riveOnInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: "State Machine");
                      isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                      isSideBarClosed.value = true;
                    },
                    press: () {
                      isSideBarClosed.value = !isSideBarClosed.value;
                      if (isSideNavBarClosed) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                      setState(() {
                        isSideNavBarClosed = isSideBarClosed.value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    Curriculum(),
    HomePage(),
    LeaderBoardScreen(),
  ];
  final screenTitle = [
    S.current.subjects,
    S.current.home,
    S.current.leaderBoard
  ];
}
