import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/home_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/home/widgets_home/advertise_img_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../config/sizes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // Screen height and width from MediaQuery
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.02),
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
                    color: AppColors.darkMainColor, // Container color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
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
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: SizeConfig.screenWidth! * 0.141,
                                    backgroundColor: Colors.grey[200],
                                    child: ClipOval(
                                      child: userController.user.value!
                                                  .userProfileImgUrl !=
                                              ''
                                          ? CachedNetworkImage(
                                              key: ValueKey(userController.user
                                                  .value!.userProfileImgUrl),
                                              imageUrl: userController.user
                                                  .value!.userProfileImgUrl!,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              fit: BoxFit.cover,
                                              width: SizeConfig.screenWidth! *
                                                  0.282,
                                              height: SizeConfig.screenWidth! *
                                                  0.282,
                                            )
                                          : Image.asset(
                                              Images.test,
                                              fit: BoxFit.cover,
                                              width: SizeConfig.screenWidth! *
                                                  0.282,
                                              height: SizeConfig.screenWidth! *
                                                  0.282,
                                            ),
                                    ),
                                  ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                      width: SizeConfig.screenWidth! * 0.03),
                                  // Spacing adjusted based on screen width
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hi, ${userController.currentUser!.fullName}",
                                        style: const TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.screenHeight! * 0.01),
                                      Text(
                                        'Rank: #${controller.rank.value}',
                                        style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Overall points: ${controller.overallPoints.value}",
                                        style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "This month points: ${controller.point.value}",
                                        style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.screenHeight! * 0.03),
                              // const UserPointsProgressBar(),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: controller.point.value /
                                          controller.maxPoint.value,
                                      // Bind progress value
                                      backgroundColor: AppColors.mainColor,
                                      color: AppColors.secondaryColor,
                                      minHeight: 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${((controller.point.value / controller.maxPoint.value) * 100).toStringAsFixed(2)}%',
                                      style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                  )),
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.03), // Adjusted spacing
              // Image and indicator slider
              AdvertiseImgsCarousel(),
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.02), // Adjusted spacing
              // History part
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkMainColor, // Container color
                  borderRadius: BorderRadius.circular(12), // Rounded corners
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your latest Exams",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.02),

              Obx(
                    () =>
                    controller.userExamHistoryIsLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.userExamHistory.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Go get some exams",
                              style: TextStyle(
                                color: AppColors.darkMainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: controller.userExamHistory.length,
                            itemBuilder: (context, index) {
                              final examResult =
                                  controller.userExamHistory[index];
                              double percentage =
                                  (examResult["correctAnswers"] /
                                      examResult["totalQuestions"]);
                              double roundedPercentage =
                                double.parse((percentage).toStringAsFixed(1));
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // controller.resetExam();
                                    // controller.setUnitQuestions(examResult["questions"]);
                                    // Get.to(() => const PreExam());
                                  },
                                  child: SizedBox(
                                    height: SizeConfig.screenHeight! * 0.12,
                                    child: Card(
                                      color: AppColors.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircularPercentIndicator(
                                              radius: 30.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 5.0,
                                              percent: roundedPercentage,
                                              center: Text(
                                                  "${roundedPercentage * 100}%"),
                                              progressColor: (examResult[
                                                              "correctAnswers"] /
                                                          examResult[
                                                              "totalQuestions"]) >
                                                      0.5
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                      decoration: const BoxDecoration(
                                                          color: AppColors
                                                              .lightenMainColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20))),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                              "${examResult["examName"]}",
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .darkMainColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12)))),
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
                                                          child: const Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child: Text("Passed",
                                                                  style: TextStyle(
                                                                      color: AppColors.successColor,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 12))))
                                                      : Container(
                                                        decoration: const BoxDecoration(
                                                            color: AppColors
                                                                .errorBoxColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Text(
                                                                "Failed",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .errorColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12)),
                                                          ),
                                                        ),
                                                  // Text(
                                                  //   "${examResult["examName"]}",
                                                  //   style: const TextStyle(
                                                  //     fontSize: 12,
                                                  //     fontWeight:
                                                  //         FontWeight.w700,
                                                  //   ),
                                                  // ),
                                                  Text(
                                                    examResult["examType"] ==
                                                            "UnitExam"
                                                        ? "Unit Exam"
                                                        : "Final Exam",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Correct Answers: ${examResult["correctAnswers"]} / ${examResult["totalQuestions"]}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF3CD797),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "${examResult["points"]} points",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.right,
                                                ),
                                                Text(
                                                  DateFormat('MMM d, y h:mm a')
                                                      .format(examResult["date"]
                                                          .toDate()),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                              size: 20,
                                              color: AppColors.darkMainColor,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  // Function to convert UTF-16 LE bytes to a UTF-8 string
  String convertUtf16ToUtf8(Uint8List bytes) {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < bytes.length; i += 2) {
      int charCode = bytes[i] + (bytes[i + 1] << 8);
      buffer.writeCharCode(charCode);
    }
    return buffer.toString(); // No need to encode again, return UTF-16 string
  }

  void exportData() async {
    final CollectionReference subjectsCollection =
        FirebaseFirestore.instance.collection("subjects_ar_12");

    try {
      final uid = AuthenticationRepository.instance.getUserID;
      print(uid); // Prints the user's UID
      final email = AuthenticationRepository.instance.getUserEmail;
      print(email); // Prints the user's email address
      final name = AuthenticationRepository.instance.getDisplayName;
      print("Welcome, $name!");
      final getPhoneNo = AuthenticationRepository.instance.getPhoneNo;
      print(getPhoneNo); // Prints the user's email address
      final phone = AuthenticationRepository.instance.getPhoneNo;
      print(phone);

      // Additional code for exporting data (commented out for brevity)
    } catch (e) {
      print("Error exporting data: $e");
    }
  }
}
