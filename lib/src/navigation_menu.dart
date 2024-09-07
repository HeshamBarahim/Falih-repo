// import 'package:flutter/foundation.dart';
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
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ),
        bottomNavigationBar: Obx(
          () => ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: NavigationBar(
                height: 100,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.menu_book_outlined), label: 'subjects'),
                  NavigationDestination(icon: Icon(Icons.home), label: 'home'),
                  NavigationDestination(
                      icon: Icon(Icons.leaderboard_outlined),
                      label: 'LeaderBoard'),
                ]),
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Curriculum(),
    const HomePage(),
    const Leaderboard(),
  ];
}
