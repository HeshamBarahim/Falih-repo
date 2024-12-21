// Subjects_Label
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../config/themes.dart';
import '../../../controller/exam_controller.dart';
import '../../../controller/subjects_controller.dart';
import '../../pre_exam/pre_exam.dart';

class SubjectsLabels extends StatelessWidget {
  final SubjectsController subjectController = Get.put(SubjectsController());
  final ExamController controller = Get.put(ExamController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<SubjectsLabelsData> items = [
      SubjectsLabelsData("Unit Exams", Icons.app_shortcut_sharp, ''),
      SubjectsLabelsData("Exams", Icons.bookmarks_sharp, '/runExam'),
      SubjectsLabelsData("Results", Icons.stacked_line_chart, ''),
    ];

    return Expanded(
      child: Transform.translate(
        offset: Offset(0, -screenHeight * 0.05), // Push up based on height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  items.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        if (index == 1) {
                          controller.examType.value = "FinalExam";
                          controller.setExamQuestions();
                          Get.to(() => const PreExam());
                          return;
                        }
                        subjectController.changeSelectedIndex(index);
                      },
                      child: Obx(() => Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.3,
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01,
                                horizontal: screenWidth * 0.02),
                            decoration: BoxDecoration(
                              color:
                                  subjectController.selectedIndex.value == index
                                      ? AppColors.choicesColor
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  items[index].labelName,
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenHeight * 0.015,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
            Obx(() {
              if (subjectController.selectedIndex.value == 0) {
                return _buildUnitsExams(context);
              } else if (subjectController.selectedIndex.value == 2) {
                return _buildResultsContent(context);
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }

  Widget _buildUnitsExams(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10, // Example count
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: GestureDetector(
              onTap: () {
                controller.resetExam();
                controller.setUnitQuestions([]);
                Get.to(() => const PreExam());
              },
              child: Card(
                color: const Color(0xFFFBF7FC),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.00948),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(radius: screenHeight * 0.035),
                      SizedBox(width: screenWidth * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chapter: ${index + 1}",
                              style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Unit Name",
                              style: TextStyle(
                                fontSize: screenHeight * 0.015,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "10 Questions",
                        style: TextStyle(
                          color: AppColors.successColor,
                          fontWeight: FontWeight.w500,
                          fontSize: screenHeight * 0.018,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: screenHeight * 0.025,
                        color: const Color(0xFF743089),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultsContent(BuildContext context) {
    // Implement similar responsive logic here
    return Container();
  }
}

class SubjectsLabelsData {
  String labelName;
  IconData icon;
  String routePath;

  SubjectsLabelsData(this.labelName, this.icon, this.routePath);
}
