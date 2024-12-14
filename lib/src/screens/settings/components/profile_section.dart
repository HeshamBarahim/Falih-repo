import 'package:cached_network_image/cached_network_image.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:get/get.dart';

class ProfileSection extends StatelessWidget {
  final String profileImage;
  final String name;
  final String email;

  ProfileSection(
      {super.key,
      required this.profileImage,
      required this.name,
      required this.email});

  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        children: [
          CircleAvatar(
              radius: SizeConfig.screenWidth! * 0.12,
              backgroundColor: Colors.grey[200],
              child: Obx(() {
                if (userController.profileImageUrl.isEmpty) {
                  return ClipOval(
                    child: Image.asset(Images.test),
                  );
                }
                return ClipOval(
                    child: CachedNetworkImage(
                  imageUrl: userController.profileImageUrl.value,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: SizeConfig.screenWidth! * 0.282,
                  height: SizeConfig.screenWidth! * 0.282,
                ));
              })),
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
