import 'package:cached_network_image/cached_network_image.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';
import '../../../controller/leaderboard_controller.dart';

class TopLeaderboardSection extends StatelessWidget {
  TopLeaderboardSection({
    super.key,
  });

  final leaderboardController = Get.find<LeaderboardController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<int> topUserOrder = [1, 0, 2]; // Custom order: second, first, third

    return Container(
      height: screenHeight * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: topUserOrder.map((index) {
          final user = leaderboardController.leaderboardUsers.value[index];

          bool isMiddleUser = index == 0;
          bool isSecondUser = index == 1;
          bool isThirdUser = index == 2;
          bool hasCrown = isMiddleUser;

          return Expanded(
            flex: isMiddleUser ? 5 : 4,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: isMiddleUser ? screenHeight * 0.08 : screenHeight * 0.12,
                  // bottom: screenHeight * 0.08,
                  child: Container(
                    height: isMiddleUser
                        ? screenHeight * 0.19
                        : screenHeight * 0.14,
                    width: screenWidth * 0.29,
                    padding: EdgeInsets.only(
                        top: isMiddleUser
                            ? screenHeight * 0.071
                            : screenHeight * 0.051),
                    decoration: BoxDecoration(
                      color: isMiddleUser
                          ? AppColors.mainColor
                          : Get.isDarkMode
                              ? AppColors.lightenMainColor
                              : AppColors.moreLightenMainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isMiddleUser
                            ? screenWidth * 0.073
                            : screenWidth * 0.06),
                        topRight: Radius.circular(isMiddleUser
                            ? screenWidth * 0.073
                            : screenWidth * 0.06),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkMainColor,
                          offset: Offset(0, screenHeight * 0.005),
                          blurRadius: screenHeight * 0.01,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            user["name"]
                                    .toString()
                                    .split(" ")[0]
                                    .capitalizeFirst ??
                                "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold,
                              color: isMiddleUser
                                  ? AppColors.secondaryColor
                                  : AppColors.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.003),
                        Text(
                          '${user["points"] ?? 0} p',
                          style: const TextStyle(
                            color: AppColors.successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: isMiddleUser
                          ? screenHeight * 0.027
                          : screenHeight * 0.06,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.successColor,
                            width: screenWidth * 0.01,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: isMiddleUser
                              ? screenWidth * 0.1
                              : screenWidth * 0.085,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              key: ValueKey(user["name"]),
                              imageUrl:
                                  "${user["name"]}?w=${(SizeConfig.screenWidth! * 0.282).toInt()}&h=${(SizeConfig.screenWidth! * 0.282).toInt()}",
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) {
                                String userName = user["name"];
                                String initial = userName.isNotEmpty
                                    ? userName[0].toUpperCase()
                                    : "U";

                                return CircleAvatar(
                                  radius: (SizeConfig.screenWidth! * 0.141),
                                  // Half of image size
                                  backgroundColor: AppColors.mainColor,
                                  // You can change the color
                                  child: Text(
                                    initial,
                                    style: TextStyle(
                                      fontSize: (SizeConfig.screenWidth! *
                                          0.08), // Responsive text size
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
                          // backgroundImage:
                          //     NetworkImage(user.userProfileImgUrl ?? ""),
                          // onBackgroundImageError: (_, __) =>
                          //     const AssetImage('assets/images/placeholder.png'),
                        ),
                      ),
                    ),
                    if (hasCrown)
                      Positioned(
                        top: 0,
                        child: Image.asset(
                          Images.crownIcon,
                          width: screenWidth * 0.085,
                        ),
                      ),
                    if (isMiddleUser || isSecondUser || isThirdUser)
                      Positioned(
                        top: isMiddleUser
                            ? screenHeight * 0.118
                            : screenHeight * 0.14,
                        child: Transform.rotate(
                          angle: 38.5,
                          child: Container(
                            height: screenWidth * 0.048,
                            width: screenWidth * 0.048,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3CD797),
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.012),
                            ),
                            child: Transform.rotate(
                              angle: 49.5,
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
