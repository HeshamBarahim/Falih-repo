import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/leaderboard_controller.dart';
import 'components/leaderboard_list_section.dart';
import 'components/top_leaderboard_section.dart';

class LeaderBoardScreen extends StatelessWidget {
  static const String scRoute = '/leader-board-screen';

  LeaderBoardScreen({super.key});

  final controller = Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TopLeaderboardSection(),
                Expanded(
                  child: Container(
                    // height: SizeConfig.screenHeight! * 0.38,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 70),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children:
                          controller.usersList.asMap().entries.map((element) {
                        final index = element.key; // The index of the user
                        final user = element.value; // The user object

                        return LeaderboardListSection(
                            id: user.id ?? "",
                            rank: index + 1,
                            name: user.fullName,
                            points: controller.userPoints[user.id] ?? 0);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
