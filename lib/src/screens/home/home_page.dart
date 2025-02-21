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

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
                  color: AppColors.moreLightenMainColor, // Container color
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
                          backgroundColor: AppColors.darkMainColor,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              key: ValueKey(userController
                                      .user.value?.userProfileImgUrl ??
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
                                  radius: (SizeConfig.screenWidth! * 0.141),
                                  // Half of image size
                                  backgroundColor: AppColors.mainColor,
                                  // You can change the color
                                  child: Text(
                                    initial,
                                    style: TextStyle(
                                      fontSize:
                                          (SizeConfig.screenWidth! * 0.08),
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
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${S.of(context).hi}${userController.currentUser!.fullName.split(" ")[0]}",
                                  style: const TextStyle(
                                      color: AppColors.darkMainColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight! * 0.01),
                                Obx(
                                  () => controller.isLoading.value
                                      ? const SizedBox(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${S.of(context).rank}: #${controller.rank.value}",
                                              style: const TextStyle(
                                                color: AppColors.darkMainColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${S.of(context).over_all_points}: ${controller.overallPoints.value}",
                                              style: const TextStyle(
                                                color: AppColors.darkMainColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${S.of(context).this_month_points}: ${controller.point.value}",
                                              style: const TextStyle(
                                                color: AppColors.darkMainColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
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
                    Get.locale?.languageCode == "Ar"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: controller.point.value /
                                      controller.maxPoint.value,
                                  // Bind progress value
                                  backgroundColor: AppColors.mainColor,
                                  color: AppColors.lightenMainColor,
                                  minHeight: 10,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${((controller.point.value / controller.maxPoint.value) * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                      color: AppColors.darkMainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // Aligns children to the end (right for LTR, left for RTL)
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${((controller.point.value / controller.maxPoint.value) * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                      color: AppColors.darkMainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: controller.point.value /
                                      controller.maxPoint.value,
                                  // Bind progress value
                                  backgroundColor: AppColors.mainColor,
                                  color: AppColors.lightenMainColor,
                                  minHeight: 10,
                                ),
                              ),
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
              // Adjusted spacing
              // History part
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkMainColor, // Container color
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
                                child: AspectRatio(
                                  aspectRatio:
                                      1, // 1:1 ratio (square), adjust as needed
                                  child: Lottie.asset(Images.emptyAnimation),
                                ),
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
                                      color: AppColors.moreLightenMainColor,
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
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.mainColor),
                                              ),
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
                                                            // "${examResult["examName"]}"
                                                            getSectionDisplayName(
                                                                examResult[
                                                                    "examName"]),
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .darkMainColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    12)))),
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
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        8.0),
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
                                                                BorderRadius
                                                                    .all(Radius
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
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  getTypeExamDisplayName(
                                                      examResult["examType"]),
                                                  style: const TextStyle(
                                                    color: AppColors.mainColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
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
                                                    color:
                                                        AppColors.shadowColor,
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
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.mainColor),
                                                ),
                                                Text(
                                                  "${examResult["points"]} ${S.of(context).points}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.mainColor),
                                                ),
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
                              child: const Text(
                                'See More',
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                          : const SizedBox
                              .shrink(); // Hide the button when all items are loaded
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   // Function to convert UTF-16 LE bytes to a UTF-8 string
//   String convertUtf16ToUtf8(Uint8List bytes) {
//     StringBuffer buffer = StringBuffer();
//     for (int i = 0; i < bytes.length; i += 2) {
//       int charCode = bytes[i] + (bytes[i + 1] << 8);
//       buffer.writeCharCode(charCode);
//     }
//     return buffer.toString(); // No need to encode again, return UTF-16 string
//   }

//   void exportData() async {
//     final CollectionReference subjectsCollection =
//         FirebaseFirestore.instance.collection("subjects_ar_12");

//     try {
//       final uid = AuthenticationRepository.instance.getUserID;
//       print(uid); // Prints the user's UID
//       final email = AuthenticationRepository.instance.getUserEmail;
//       print(email); // Prints the user's email address
//       final name = AuthenticationRepository.instance.getDisplayName;
//       print("Welcome, $name!");
//       final getPhoneNo = AuthenticationRepository.instance.getPhoneNo;
//       print(getPhoneNo); // Prints the user's email address
//       final phone = AuthenticationRepository.instance.getPhoneNo;
//       print(phone);

//       // Additional code for exporting data (commented out for brevity)
//     } catch (e) {
//       print("Error exporting data: $e");
//     }
//   }

  String getSectionDisplayName(String key) {
    // print("fksjgjgskgj $key");
    switch (key) {
      case "geography":
        return "جغرافيا";
      case "history":
        return "تاريخ";
      case "nationalism":
        return "وطنية";
      case "physics":
        return S.current.subject_six;
      case "biology":
        return S.current.subject_seven;
      case "chemistry":
        return S.current.subject_five;
      case "iman":
        return "ُالإيمان";
      case "fiqh":
        return "الفقة";
      case "hadith":
        return "الحديث";
      case "seerah":
        return "السيرة";
      case "grammar_morphology":
        return "النحو والصرف";
      case "literature_texts":
        return "الأدب والنصوص";
      case "reading":
        return "القراءة";
      case "criticism":
        return "النقد";
      case "tafsir_alquran":
        return "الحفظ والتفسير";
      case "uloom_alquran":
        return "علوم القرآن";
      case "tajweed":
        return "التجويد";
      case "quran":
        return S.current.subject_one;
      case "arabic":
        return S.current.subject_three;

      default:
        return key.capitalizeFirst ?? key;
    }
  }

  String getTypeExamDisplayName(String key) {
    // print("Plan ID from Firebase: $key");
    switch (key) {
      case "FinalExam":
        return S.current.final_exam;
      case "UnitExam":
        return S.current.unit_exam;

      default:
        return key.capitalizeFirst ?? key;
    }
  }
}
