import 'package:cached_network_image/cached_network_image.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/home_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/screens/home/widgets_home/advertise_img_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../config/images.dart';
import '../../config/sizes.dart';
import '../../constants/functions.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The heading profile
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 0.04,
                  vertical: SizeConfig.screenHeight! * 0.02),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainColor, // Border color
                  width: 1.5, // Border width
                ),
                color: Theme.of(context).colorScheme.primary,

                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkMainColor.withOpacity(0.5),
                    // Shadow color
                    spreadRadius: 2,
                    // Spread of the shadow
                    blurRadius: 10,
                    // Blur effect
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: SizeConfig.screenWidth! * 0.13,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            key: ValueKey(
                                userController.user.value?.userProfileImgUrl ??
                                    ""),
                            imageUrl:
                                "${userController.user.value!.userProfileImgUrl}?w=${(SizeConfig.screenWidth! * 0.282).toInt()}&h=${(SizeConfig.screenWidth! * 0.282).toInt()}",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              String userName =
                                  userController.user.value!.fullName;
                              String initial = userName.isNotEmpty
                                  ? userName[0].toUpperCase()
                                  : "U";

                              return CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  radius: (SizeConfig.screenWidth! * 0.141),
                                  child: Text(initial,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 48)));
                            },
                            fit: BoxFit.cover,
                            width: SizeConfig.screenWidth! * 0.282,
                            height: SizeConfig.screenWidth! * 0.282,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${S.of(context).hi}${userController.currentUser!.fullName.split(" ")[0]}",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: SizeConfig.screenHeight! * 0.01),
                              Obx(
                                () => controller.isLoading.value
                                    ? const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${S.of(context).rank}: #${controller.rank.value}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text(
                                              "${S.of(context).over_all_points}: ${controller.overallPoints.value}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text(
                                              "${S.of(context).this_month_points}: ${controller.monthlyPoints.value}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ],
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.03),
                  Get.locale?.languageCode == "ar"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: controller.monthlyPoints.value /
                                    controller.maxPoint.value,
                                // Bind progress value
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                color: Theme.of(context).colorScheme.primary,
                                minHeight: 10,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                  '${((controller.monthlyPoints.value / controller.maxPoint.value) * 100).toStringAsFixed(2)}%',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                  '${((controller.monthlyPoints.value / controller.maxPoint.value) * 100).toStringAsFixed(2)}%',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 2), // Add border
                                borderRadius: BorderRadius.circular(
                                    0), // Optional: Rounded corners
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                // Match border radius to avoid overflow
                                child: LinearProgressIndicator(
                                  value: controller.monthlyPoints.value /
                                      controller.maxPoint.value,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  color: Theme.of(context).colorScheme.primary,
                                  minHeight: 10,
                                ),
                              ),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('${controller.maxPoint.value}',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            )
                          ],
                        )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.03),
            // Adjusted spacing
            // Image and indicator slider
            AdvertiseImgsCarousel(),
            SizedBox(height: SizeConfig.screenHeight! * 0.02),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface, // Container color
                borderRadius: BorderRadius.circular(8), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainColor.withOpacity(0.5),
                    // Shadow color
                    spreadRadius: 2,
                    // Spread of the shadow
                    blurRadius: 10,
                    // Blur effect
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).your_latest_exams,
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.02),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  Obx(() => controller.userExamHistoryIsLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.visibleExams.isEmpty
                          ? Center(
                              child: Lottie.asset(
                                  width: 200, // Set your desired width
                                  height: 200, // Set your desired height
                                  fit: BoxFit.fill,
                                  Images.emptyAnimation),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: controller.visibleExams.length,
                                itemBuilder: (context, index) {
                                  final examResult =
                                      controller.visibleExams[index];
                                  double percentage =
                                      (examResult["correctAnswers"] /
                                          examResult["totalQuestions"]);
                                  double roundedPercentage = double.parse(
                                      (percentage).toStringAsFixed(1));
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    elevation: 10,
                                    shadowColor: AppColors.darkMainColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 30.0,
                                            animation: true,
                                            animationDuration: 1200,
                                            lineWidth: 4.0,
                                            percent: roundedPercentage,
                                            center: Text(
                                                "${roundedPercentage * 100}%",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                            progressColor: (examResult[
                                                            "correctAnswers"] /
                                                        examResult[
                                                            "totalQuestions"]) >
                                                    0.5
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                  decoration: const BoxDecoration(
                                                      color: AppColors
                                                          .lightenMainColor,
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20))),
                                                  child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                          getSectionDisplayName(
                                                              examResult[
                                                                  "examName"]),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .darkMainColor,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              fontSize: 12)))),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              (examResult["correctAnswers"] /
                                                          examResult[
                                                              "totalQuestions"]) >
                                                      0.5
                                                  ? Container(
                                                      decoration: const BoxDecoration(
                                                          color: AppColors
                                                              .successBoxColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20))),
                                                      child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                          child: Text(S.of(context).passed,
                                                              style: const TextStyle(
                                                                  color: AppColors.successColor,
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12))))
                                                  : Container(
                                                      decoration: const BoxDecoration(
                                                          color: AppColors
                                                              .errorBoxColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                            S
                                                                .of(context)
                                                                .failed,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .errorColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12)),
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  getTypeExamDisplayName(
                                                      examResult["examType"]),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall)
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${S.of(context).correct_answers}: ${examResult["correctAnswers"]} / ${examResult["totalQuestions"]}",
                                                style: const TextStyle(
                                                  color: AppColors.shadowColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                  "${S.of(context).on}: ${DateFormat('yyyy-MM-dd HH:mm').format(examResult["date"].toDate())}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.right,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              Text(
                                                  "${examResult["points"]} ${S.of(context).points}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.right,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                  Obx(() {
                    return controller.currentExamItemCount.value <
                            controller.userExamHistory.length
                        ? GestureDetector(
                            onTap: controller.loadMore,
                            child: Text('See More',
                                style: Theme.of(context).textTheme.bodyMedium))
                        : const SizedBox
                            .shrink(); // Hide the button when all items are loaded
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
