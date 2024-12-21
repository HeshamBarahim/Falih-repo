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
    return SizedBox(
        height: 70.0,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => ClipOval(
                child: userController.profileImageUrl.value != null
                    ? CachedNetworkImage(
                        key: ValueKey(userController.profileImageUrl.value),
                        imageUrl: userController.profileImageUrl.value!,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: SizeConfig.screenWidth! * 0.20,
                      )
                    : Image.asset(
                        Images.test,
                        fit: BoxFit.cover,
                        width: SizeConfig.screenWidth! * 0.20,
                      ),
              ),
            ),
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
        ));
  }
}
