import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';

class ProfileSection extends StatelessWidget {
  final String profileImage;
  final String name;
  final String email;

  const ProfileSection(
      {super.key,
      required this.profileImage,
      required this.name,
      required this.email});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            // radius: SizeConfig.screenHeight! * 0.059,
            radius: SizeConfig.screenWidth! * 0.12,
            backgroundImage: NetworkImage(
              profileImage,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.012),
          Text(
            name,
            style: TextStyle(
              // fontSize: SizeConfig.screenHeight! * 0.026,
              fontSize: SizeConfig.screenWidth! * 0.053,
              fontWeight: FontWeight.bold,
              color: fontColor_1,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.006),
          Text(
            email,
            style: TextStyle(
              // fontSize: SizeConfig.screenHeight! * 0.019,
              fontSize: SizeConfig.screenWidth! * 0.039,
              color: fontColor_1,
            ),
          ),
        ],
      ),
    );
  }
}
