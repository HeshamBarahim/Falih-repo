// navbar_info_card
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';
import '../../../config/themes.dart';
import '../../../controller/user_controller.dart';

class NavBarInfoCard extends StatelessWidget {
  NavBarInfoCard({
    super.key,
  });

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight! * 0.01,
      ),
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.035),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            final user = userController.user.value;

            return CircleAvatar(
              radius: SizeConfig.screenWidth! * 0.11,
              child: ClipOval(
                  child: CachedNetworkImage(
                key: ValueKey(user?.userProfileImgUrl),
                imageUrl: user!.userProfileImgUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) {
                  String? userName = user.fullName;
                  String initial =
                      userName.isNotEmpty ? userName[0].toUpperCase() : "U";

                  return CircleAvatar(
                    radius: (SizeConfig.screenWidth! * 0.141),
                    // Half of image size
                    backgroundColor: AppColors.mainColor,
                    // You can change the color
                    child: Text(
                      initial,
                      style: TextStyle(
                        fontSize: (SizeConfig.screenWidth! * 0.08),
                        // Responsive text size
                        fontWeight: FontWeight.bold,
                        color: AppColors.moreLightenMainColor,
                      ),
                    ),
                  );
                },
                fit: BoxFit.cover,
                width: SizeConfig.screenWidth! * 0.282,
                height: SizeConfig.screenWidth! * 0.282,
              )),
            );
          }),
          SizedBox(width: SizeConfig.screenWidth! * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userController.user.value?.fullName.capitalize ?? "user",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.screenHeight! * 0.019,
                ),
              ),
              Text(
                userController.user.value?.schoolName.capitalize ?? "",
                // userController.user.value?.schoolName ?? "user",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenHeight! * 0.014,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
