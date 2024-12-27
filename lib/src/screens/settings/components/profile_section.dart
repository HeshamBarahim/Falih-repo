import 'package:cached_network_image/cached_network_image.dart';
import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({
    super.key,
  });

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        children: [
          // GetBuilder<ProfileController>(
          //   init: ProfileController(),
          //   builder: (controller) => ClipOval(
          //     child: controller.isProfileImgLoading
          //         ? Center(
          //             child: CircularProgressIndicator(
          //               strokeWidth: SizeConfig.screenWidth! * 0.008,
          //               strokeAlign: SizeConfig.screenWidth! * 0.003,
          //             ),
          //           )
          //         : controller.userProfileImgUrl != null
          //             ? CachedNetworkImage(
          //                 key: ValueKey(controller.userProfileImgUrl),
          //                 imageUrl: controller.userProfileImgUrl.value!,
          //                 placeholder: (context, url) =>
          //                     const CircularProgressIndicator(),
          //                 errorWidget: (context, url, error) =>
          //                     const Icon(Icons.error),
          //                 fit: BoxFit.cover,
          //                 width: SizeConfig.screenWidth! * 0.282,
          //                 height: SizeConfig.screenWidth! * 0.282,
          //               )
          //             : Image.asset(
          //                 Images.test,
          //                 fit: BoxFit.cover,
          //                 width: SizeConfig.screenWidth! * 0.282,
          //                 height: SizeConfig.screenWidth! * 0.282,
          //               ),
          //   ),
          // ),
          Obx(
            () => CircleAvatar(
              radius: SizeConfig.screenWidth! * 0.141,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: userController.isProfileImgLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: SizeConfig.screenWidth! * 0.008,
                          strokeAlign: SizeConfig.screenWidth! * 0.003,
                        ),
                      )
                    : userController.user.value!.userProfileImgUrl != ''
                        ? CachedNetworkImage(
                            key: ValueKey(
                                userController.user.value!.userProfileImgUrl),
                            imageUrl:
                                userController.user.value!.userProfileImgUrl!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: SizeConfig.screenWidth! * 0.282,
                            height: SizeConfig.screenWidth! * 0.282,
                          )
                        : Image.asset(
                            Images.test,
                            fit: BoxFit.cover,
                            width: SizeConfig.screenWidth! * 0.282,
                            height: SizeConfig.screenWidth! * 0.282,
                          ),
              ),
            ),
          ),

          SizedBox(height: SizeConfig.screenHeight! * 0.012),
          Text(
            userController.user.value?.fullName ?? "",
            style: TextStyle(
              // fontSize: SizeConfig.screenHeight! * 0.026,
              fontSize: SizeConfig.screenWidth! * 0.053,
              fontWeight: FontWeight.bold,
              color: fontColor_1,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.006),
          Text(
            userController.user.value?.schoolName ?? "",
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
