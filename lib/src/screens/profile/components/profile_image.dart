import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imgURL;
  final VoidCallback changeImageFunction;
  const ProfileImage(
      {super.key, required this.imgURL, required this.changeImageFunction});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: SizeConfig.screenWidth! * 0.121,
            backgroundImage: NetworkImage(
              imgURL,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: SizeConfig.screenWidth! * 0.07,
              width: SizeConfig.screenWidth! * 0.07,
              child: IconButton(
                onPressed: changeImageFunction,
                style: IconButton.styleFrom(
                  backgroundColor: iconColor_2,
                ),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: SizeConfig.screenWidth! * 0.034,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
