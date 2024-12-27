import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/home_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/home/widgets_home/custom_carousel.dart';
import 'package:falih/src/screens/home/widgets_home/custom_progress_bar.dart';
import 'package:falih/src/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

import 'package:get/get.dart';

import '../../config/const.dart';
import '../../config/sizes.dart';
import '../../controller/profile_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = Get.put(HomeController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // Screen height and width from MediaQuery
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.02,
            vertical: SizeConfig.screenHeight! * 0.01),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The heading profile
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.04,
                    vertical: SizeConfig.screenHeight! * 0.02),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor, // Container color
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread of the shadow
                      blurRadius: 10, // Blur effect
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Circular avatar for the photo
                        GetBuilder<ProfileController>(
                          init: ProfileController(),
                          builder: (controller) => CircleAvatar(
                            radius: SizeConfig.screenWidth! * 0.141,
                            backgroundColor: Colors.grey[200],
                            child: ClipOval(
                              child: controller.isProfileImgLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth:
                                            SizeConfig.screenWidth! * 0.008,
                                        strokeAlign:
                                            SizeConfig.screenWidth! * 0.003,
                                      ),
                                    )
                                  : controller.userProfileImgUrl.value != ''
                                      ? CachedNetworkImage(
                                          key: ValueKey(
                                              controller.userProfileImgUrl),
                                          imageUrl: controller
                                              .userProfileImgUrl.value!,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          width:
                                              SizeConfig.screenWidth! * 0.282,
                                          height:
                                              SizeConfig.screenWidth! * 0.282,
                                        )
                                      : Image.asset(
                                          Images.test,
                                          fit: BoxFit.cover,
                                          width:
                                              SizeConfig.screenWidth! * 0.282,
                                          height:
                                              SizeConfig.screenWidth! * 0.282,
                                        ),
                            ),
                          ),
                        ),

                        SizedBox(
                            width: SizeConfig.screenWidth! *
                                0.03), // Spacing adjusted based on screen width
                        // Information about the user and his rank
                        Obx(
                          () => userController.currentUser == null
                              ? const Text("User data not available.")
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Hi, ${userController.currentUser!.fullName}"),
                                    SizedBox(
                                        height: SizeConfig.screenHeight! *
                                            0.01), // Adjust spacing based on screen height
                                    const Text('#3 Rank'),
                                    const Text("2,639/5,999 Points"),
                                  ],
                                ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: SizeConfig.screenHeight! *
                            0.03), // Adjusted spacing
                    // Progress bar
                    Obx(() => CustomProgressBar(
                          width: SizeConfig.screenWidth! *
                              0.65, // Adjust width dynamically
                          height: SizeConfig.screenHeight! *
                              0.02, // Adjust height dynamically
                          progress: homeController.percentage.value,
                        )),
                  ],
                ),
              ),
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.03), // Adjusted spacing
              // Image and indicator slider
              Obx(() => CustomCarousel(
                    // Convert String paths to Image widgets
                    images: homeController.images
                        .map((imagePath) => Image.asset(imagePath))
                        .toList(),
                  )),
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.02), // Adjusted spacing
              // History part
              Text(
                "Your Test History",
                style: TextStyle(
                  color: Color(0xFF743089),
                  fontSize: SizeConfig.screenHeight! *
                      0.025, // Adjusted font size based on screen height
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.02), // Adjusted spacing
              ElevatedButton(
                onPressed: exportData,
                child: Text(
                  'export CSV',
                  style: TextStyle(
                    color: Color(0xFF743089),
                    fontSize:
                        SizeConfig.screenHeight! * 0.022, // Adjusted font size
                  ),
                ),
              ),
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.02), // Adjusted spacing
              ElevatedButton(
                onPressed: () => Get.to(() => SettingsScreen()),
                child: Text(
                  'go to settings',
                  style: TextStyle(
                    color: Color(0xFF743089),
                    fontSize:
                        SizeConfig.screenHeight! * 0.022, // Adjusted font size
                  ),
                ),
              ),
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
