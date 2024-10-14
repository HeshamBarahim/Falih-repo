import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/home_controller.dart';
import 'package:falih/src/screens/home/widgets_home/custom_carousel.dart';
import 'package:falih/src/screens/home/widgets_home/custom_progress_bar.dart';
import 'package:falih/src/screens/home/widgets_home/custom_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'dart:async' show Future;
import 'dart:convert';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    offset: const Offset(
                        0, 5), // Position of the shadow (horizontal, vertical)
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // circulr avatar for the photo
                      CircleAvatar(
                        radius: 50, // Size of the circle
                        backgroundImage: AssetImage(Images.test),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // information about the user and his rank
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi yousif,"),
                          SizedBox(
                            height: 5,
                          ),
                          Text('#3 Rank'),
                          Text("2,639/5,999 Points")
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // progress bar
                  Obx(() => CustomProgressBar(
                        width: 250,
                        height: 20,
                        progress: controller.percentage.value,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
    final CollectionReference subject =
        FirebaseFirestore.instance.collection("nationalism_unit4_9");
    try {
      // Load the CSV file as bytes
      ByteData byteData = await rootBundle
          .load("assets/csv_files/nationalism_unit4_9_test.csv");
      Uint8List bytes = byteData.buffer.asUint8List();

      // Convert from UTF-16 LE to a UTF-8 string
      String myData = convertUtf16ToUtf8(bytes);
      print("Converted Data: $myData");

      // Convert CSV file to a list of lists
      List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

      // Loop through the CSV table and create records
      for (var i = 0; i < csvTable.length; i++) {
        var record = {
          "question": csvTable[i][0],
          "ch1": csvTable[i][1],
          "ch2": csvTable[i][2],
          "ch3": csvTable[i][3],
          "ch4": csvTable[i][4],
          "answer": csvTable[i][5],
        };
        await subject.add(record); // Use await for Firestore operations
        print(record);
      }
    } catch (e) {
      print("Error exporting data: $e");
    }
  }
}
