import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/curriculum/curriculum.dart';
import 'package:falih/src/screens/home/home_page.dart';
import 'package:falih/src/screens/leaderboard/leaderboard_screen.dart';
import 'package:falih/src/screens/settings/settings_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                style: const TextStyle(
                    color: AppColors.mainColor,
                    fontFamily: 'GoogleFonts.montserratAlternatesTextTheme',
                    fontWeight: FontWeight.bold,
                    fontSize: 30))),
          ),
          backgroundColor: AppColors.moreLigtenMainColor,
          leading: IconButton(
              padding: const EdgeInsets.only(left: 20),
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                size: 40,
              ),
              color: AppColors.mainColor,
              iconSize: 30),
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 20),
              onPressed: () {
                Get.to(() => const SettingsScreen_2());
              },
              icon: const Icon(Icons.settings),
              color: AppColors.mainColor,
              iconSize: 30,
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
                  backgroundColor: AppColors.moreLigtenMainColor,
                  height: 100,
                  elevation: 0,
                  selectedIndex: controller.selectedIndex.value,
                  onDestinationSelected: (index) =>
                      controller.selectedIndex.value = index,
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(
                          Icons.menu_book_outlined,
                          color: AppColors.mainColor,
                        ),
                        label: 'Subjects'),
                    NavigationDestination(
                      icon: Icon(Icons.home, color: AppColors.mainColor),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.leaderboard_outlined,
                          color: AppColors.mainColor),
                      label: 'LeaderBoard',
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
  final screenTitle = ['Subjects', 'Home', 'LeaderBoard'];
}
