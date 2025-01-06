import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaderboardListSection extends StatelessWidget {
  final String id;
  final String name;
  final int points;
  final int rank;

  LeaderboardListSection({
    super.key,
    required this.id,
    required this.name,
    required this.points,
    required this.rank,
  });

  final UserModel? user = UserController.instance.user.value;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight! * 0.015,
        horizontal: SizeConfig.screenWidth! * 0.04,
      ),
      decoration: BoxDecoration(
        color: id == user?.id.toString()
            ? AppColors.lightenMainColor
            : AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                // Ensure it's a perfect circle
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkMainColor,
                ),
                alignment: Alignment.center,
                // Centers the text
                child: Text(
                  "#$rank",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors
                        .secondaryColor, // Add contrasting color for visibility
                  ),
                ),
              ),

              // CircleAvatar(
              //   radius: SizeConfig.screenWidth! * 0.06,
              //   // backgroundImage: AssetImage(image),
              // ),
              SizedBox(width: SizeConfig.screenWidth! * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.capitalize ?? "",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth! * 0.035,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF743089),
                    ),
                  ),
                  Text(
                    '@username',
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth! * 0.03,
                      color: const Color(0xFFBBA3C2),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '$points',
                style: TextStyle(
                  fontSize: SizeConfig.screenWidth! * 0.04,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF743089),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
