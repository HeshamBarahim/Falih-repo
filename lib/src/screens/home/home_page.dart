import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/home_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/home/widgets_home/custom_carousel.dart';
import 'package:falih/src/screens/home/widgets_home/custom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.backgroundImageOfAuth),
            fit: BoxFit.cover,
            opacity: .2,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // the heading profile
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor, // Container color
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread of the shadow
                      blurRadius: 10, // Blur effect
                      offset: const Offset(0,
                          5), // Position of the shadow (horizontal, vertical)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // circulr avatar for the photo
                        CircleAvatar(
                            radius: SizeConfig.screenWidth! * 0.12,
                            backgroundColor: Colors.grey[200],
                            child: Obx(() {
                              if (userController.profileImageUrl.isEmpty) {
                                return ClipOval(
                                  child: Image.asset(Images.test),
                                );
                              }
                              return ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: userController.profileImageUrl.value,
                                    placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: SizeConfig.screenWidth! * 0.282,
                                    height: SizeConfig.screenWidth! * 0.282,
                                  ));
                            })),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .03,
                        ),
                        // information about the user and his rank
                        Obx(
                              () => userController.currentUser == null
                              ? const Text("User data not available.")
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                    Text(
                                        "Hi, ${userController.currentUser!.fullName}"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text('#3 Rank'),
                                    const Text("2,639/5,999 Points")
                                  ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .03,
                    ),
                    // progress bar
                    Obx(() => CustomProgressBar(
                      width: 100.w,
                      height: 15.h,
                      progress: controller.percentage.value,
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .03,
              ),
              // image and indicator slider
              Obx(() => CustomCarousel(
                // Convert String paths to Image widgets
                images: controller.images
                    .map((imagePath) => Image.asset(imagePath))
                    .toList(),
              )),
              const SizedBox(
                height: 20,
              ),
              // history part
              const Text(
                "Your Test History ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(onPressed: exportData, child: Text('export CSV'))
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

      // var csvFilePath = "assets/csv_files/chemistry_unit5_9_ar_test.csv";
      // var subjectName = "chemistry_12";
      // // Load the CSV file as bytes
      // ByteData byteData = await rootBundle.load(csvFilePath);
      // Uint8List bytes = byteData.buffer.asUint8List();

      // // Convert from UTF-16 LE to a UTF-8 string
      // String myData = convertUtf16ToUtf8(bytes);
      // print("Converted Data: $myData");

      // // Convert CSV file to a list of lists
      // List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

      // // Create an array to store the new unit's questions
      // List<Map<String, dynamic>> questions = [];

      // for (var i = 0; i < csvTable.length; i++) {
      //   var question = {
      //     "question": csvTable[i][0], // The question text
      //     "choices": [
      //       // Array of choices
      //       csvTable[i][1], // Choice 1
      //       csvTable[i][2], // Choice 2
      //       csvTable[i][3], // Choice 3
      //       csvTable[i][4], // Choice 4
      //     ],
      //     "correctAnswer": csvTable[i][5], // Correct answer
      //   };

      //   questions.add(question); // Add each question to the array
      // }

      // // Add the questions as a new unit
      // var newUnit = {"questions": questions};

      // // Fetch the current document data (if it exists)
      // DocumentSnapshot subjectDoc =
      //     await subjectsCollection.doc(subjectName).get();

      // List<dynamic> currentUnits = [];

      // if (subjectDoc.exists && subjectDoc.data() != null) {
      //   // Get the existing units array
      //   currentUnits = subjectDoc["units"];
      // }

      // // Add the new unit to the current units array
      // currentUnits.add(newUnit);

      // // Update the document with the new units array
      // await subjectsCollection.doc(subjectName).update({
      //   "units": currentUnits,
      // });

      // print("Data successfully exported.");
    } catch (e) {
      print("Error exporting data: $e");
    }
  }
}
