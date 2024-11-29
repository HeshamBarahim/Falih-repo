import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

class LeaderboardListSection extends StatelessWidget {
  final String name;
  final int points;
  final String image;

  const LeaderboardListSection({
    super.key,
    required this.name,
    required this.points,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.015,
          horizontal: SizeConfig.screenWidth! * 0.04),
      decoration: BoxDecoration(
        color:
            name == 'You' ? const Color(0xFFE4CAEC) : const Color(0xFFFBF7FC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: SizeConfig.screenWidth! * 0.06,
                backgroundImage: AssetImage(image),
              ),
              SizedBox(width: SizeConfig.screenWidth! * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
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
