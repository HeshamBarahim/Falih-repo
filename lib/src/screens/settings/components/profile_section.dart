import 'package:cached_network_image/cached_network_image.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({
    super.key,
  });

  final UserController controller = UserController.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        children: [
          Obx(
            () => CircleAvatar(
              radius: SizeConfig.screenWidth! * 0.141,
              backgroundColor: AppColors.darkMainColor,
              child: ClipOval(
                child: CachedNetworkImage(
                  key: ValueKey(controller.user.value?.fullName),
                  imageUrl:
                      "${controller.user.value?.userProfileImgUrl}?w=${(SizeConfig.screenWidth! * 0.282).toInt()}&h=${(SizeConfig.screenWidth! * 0.282).toInt()}",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) {
                    String? userName = controller.user.value?.fullName;
                    String firstLetter =
                        userName!.isNotEmpty ? userName[0].toUpperCase() : "U";

                    return CircleAvatar(
                      radius: (SizeConfig.screenWidth! * 0.141),
                      backgroundColor: AppColors.mainColor,
                      child: Text(
                        firstLetter,
                        style: TextStyle(
                          fontSize: (SizeConfig.screenWidth! * 0.08),
                          fontWeight: FontWeight.bold,
                          color: AppColors.moreLightenMainColor,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  width: SizeConfig.screenWidth! * 0.282,
                  height: SizeConfig.screenWidth! * 0.282,
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.012),
          Text(controller.user.value?.fullName ?? "",
              style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: SizeConfig.screenHeight! * 0.006),
          Text(controller.user.value?.schoolName ?? "",
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
