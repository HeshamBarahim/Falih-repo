// import 'package:flutter/foundation.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/curriculum/curriculum.dart';
import 'package:falih/src/screens/home/home_page.dart';
import 'package:falih/src/screens/leaderboard/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              color: AppColors.mainColor,
              iconSize: 30),
          actions: [
            IconButton(
              onPressed: () {},
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
                  backgroundColor: Colors.white,
                  height: 100,
                  elevation: 0,
                  selectedIndex: controller.selectedIndex.value,
                  onDestinationSelected: (index) =>
                      controller.selectedIndex.value = index,
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(Icons.menu_book_outlined),
                        label: 'Subjects'),
                    NavigationDestination(
                        icon: Icon(Icons.home), label: 'Home'),
                    NavigationDestination(
                        icon: Icon(Icons.leaderboard_outlined),
                        label: 'LeaderBoard'),
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
    Leaderboard(),
  ];
}
