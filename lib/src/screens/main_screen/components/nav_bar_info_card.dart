import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../config/images.dart';
import '../../../config/sizes.dart';
import '../../../controller/profile_controller.dart';
import '../../../controller/user_controller.dart';

class NavBarInfoCard extends StatelessWidget {
  final ProfileController profileController;
  final UserController userController;
  const NavBarInfoCard({
    super.key,
    required this.profileController,
    required this.userController,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Obx(
          () => ClipOval(
            child: profileController.profileImgUrl.value != null
                ? CachedNetworkImage(
                    key: ValueKey(profileController.profileImgUrl.value),
                    imageUrl: profileController.profileImgUrl.value!,
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
              '${userController.user.value?.fullName ?? "user"} ${userController.user.value?.schoolName ?? "0"}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.screenHeight! * 0.019,
              ),
            ),
            Text(
              'Saba\'a',
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
