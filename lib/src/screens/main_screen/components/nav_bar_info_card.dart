// navbar_info_card
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/images.dart';
import '../../../config/sizes.dart';
import '../../../controller/user_controller.dart';

class NavBarInfoCard extends StatelessWidget {
  NavBarInfoCard({
    super.key,
  });

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            final user = userController.user.value;
            if (user == null ||
                user.userProfileImgUrl == null ||
                user.userProfileImgUrl!.isEmpty) {
              return CircleAvatar(
                radius: SizeConfig.screenWidth! * 0.11,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: Image.asset(
                    Images.test,
                    fit: BoxFit.cover,
                    width: SizeConfig.screenWidth! * 0.282,
                    height: SizeConfig.screenWidth! * 0.282,
                  ),
                ),
              );
            }
            return CircleAvatar(
              radius: SizeConfig.screenWidth! * 0.11,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                  child: CachedNetworkImage(
                key: ValueKey(userController.user.value!.userProfileImgUrl),
                imageUrl: userController.user.value!.userProfileImgUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
