import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/curriculum/curriculum.dart';
import 'package:falih/src/screens/home/home_page.dart';
import 'package:falih/src/screens/leaderboard/leaderboard_screen.dart';
import 'package:falih/src/screens/notification/notification_page.dart';
import 'package:falih/src/screens/profile/edit_profile_screen.dart';
import 'package:falih/src/screens/settings/settings_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Obx(() => Text(
                controller.screenTitle[controller.selectedIndex.value],
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontFamily: 'GoogleFonts.montserratAlternatesTextTheme',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp))),
          ),
          backgroundColor: AppColors.moreLigtenMainColor,
          leading: IconButton(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              onPressed: () {
                Get.to(() => EditProfileScreen());
              },
              icon: Icon(
                Icons.notifications_none,
                size: 25.w,
              ),
              color: AppColors.mainColor,
              iconSize: 25.w),
          actions: [
            IconButton(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              onPressed: () {
                Get.to(() => const SettingsScreen_2());
              },
              icon: const Icon(Icons.settings),
              color: AppColors.mainColor,
              iconSize: 25.w,
            ),
          ],
        ),
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
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(
                      0, -3), // Positioning of the shadow (vertical)
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
                  backgroundColor: AppColors.moreLigtenMainColor,
                  height: 100.h,
                  elevation: 0,
                  selectedIndex: controller.selectedIndex.value,
                  onDestinationSelected: (index) =>
                      controller.selectedIndex.value = index,
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
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
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
