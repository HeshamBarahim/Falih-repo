// Subjects_Label
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../generated/l10n.dart';
import '../../../config/themes.dart';
import '../../../controller/exam_controller.dart';
import '../../../controller/subjects_controller.dart';
import '../../../controller/user_controller.dart';
import '../../pre_exam/pre_exam.dart';

class SubjectsLabels extends StatelessWidget {
  final SubjectsController subjectController = Get.put(SubjectsController());
  final ExamController controller = Get.put(ExamController());

  SubjectsLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<SubjectsLabelsData> items = [
      SubjectsLabelsData(
          S.of(context).unit_exams, Icons.app_shortcut_sharp, ''),
      SubjectsLabelsData(
          S.of(context).exams, Icons.bookmarks_sharp, '/runExam'),
      SubjectsLabelsData(S.of(context).results, Icons.stacked_line_chart, ''),
    ];

    print(subjectController.subjectSections[subjectController.id.value]);
    return Expanded(
      child: Transform.translate(
        offset: Offset(0, -screenHeight * 0.07), // Push up based on height
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
            subjectController.subjectSections[subjectController.id.value] !=
                    null
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        subjectController
                            .subjectSections[subjectController.id.value]!
                            .length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              subjectController
                                  .changeSelectedSectionIndex(index);
                            },
                            child: Obx(() => Container(
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.3,
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01,
                                      horizontal: screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    color: subjectController
                                                .selectedSectionIndex.value ==
                                            index
                                        ? AppColors.darkMainColor
                                        : AppColors.lightenMainColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        subjectController
                                                .subjectSections[
                                                    subjectController
                                                        .id.value]![index]
                                                .capitalizeFirst ??
                                            "",
                                        style: TextStyle(
                                          color: subjectController
                                                      .selectedSectionIndex
                                                      .value ==
                                                  index
                                              ? AppColors.lightenMainColor
                                              : AppColors.darkMainColor,
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
                  )
                : Container(),
            Obx(() {
              if (subjectController.selectedIndex.value == 0) {
                return _buildUnitsExams(firestore, context);
              } else if (subjectController.selectedIndex.value == 2) {
                return _buildResultsContent(firestore);
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }

  Widget _buildUnitsExams(FirebaseFirestore firestore, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    controller.examType.value = "UnitExam";
    var user = UserController.instance.user.value;
    var subjectName = subjectController.id.value;

    if (user?.selectedGrade == "9" && subjectName == "social_studies") {
      subjectName = subjectController.subjectSections[subjectController
          .id.value]![subjectController.selectedSectionIndex.value];
    } else if (user?.selectedGrade == "9" && subjectName == "science") {
      subjectName = subjectController.subjectSections[subjectController
          .id.value]![subjectController.selectedSectionIndex.value];
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: firestore
            .collection(
                'subjects_${user?.selectedDepartment.toString().toLowerCase()}_${user?.selectedGrade.toString().toLowerCase()}')
            .doc(
                "${subjectName.toLowerCase()}_${user?.selectedGrade.toString().toLowerCase()}")
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              !snapshot.data!.exists ||
              snapshot.data!.data()!.isEmpty) {
            return Expanded(
                child: Center(child: Text(S.of(context).still_no_chapters)));
          }

          final subjectData = snapshot.data!.data() as Map<String, dynamic>;
          final units = subjectData['units'];
          controller.units = units;

          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: units.length, // Example count
              itemBuilder: (context, index) {
                final unit = units[index];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      controller.resetExam();
                      controller.setUnitQuestions(unit["questions"]);
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
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    unit["unitName"] ?? "No name",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
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
        });
  }

  Widget _buildResultsContent(FirebaseFirestore firestore) {
    var user = UserController.instance.user.value;
    var subjectName = subjectController.id.value;

    if (user?.selectedGrade == "9" && subjectName == "social_studies") {
      subjectName = subjectController.subjectSections[subjectController
          .id.value]![subjectController.selectedSectionIndex.value];
    } else if (user?.selectedGrade == "9" && subjectName == "science") {
      subjectName = subjectController.subjectSections[subjectController
          .id.value]![subjectController.selectedSectionIndex.value];
    }

    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: firestore
          .collection('exams')
          .doc(user?.id)
          .collection('userExams')
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data found'));
        }
        final examResults = snapshot.data!.docs;
        final filteredExams = examResults.where((doc) {
          final data = doc.data(); // Ensure the data is cast as a map
          return data["examName"].toString().toLowerCase() == subjectName;
        }).toList();
        if (filteredExams.isEmpty) {
          return Expanded(
              child: Center(child: Text(S.of(context).no_exams_yet)));
        }
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: filteredExams.length,
            itemBuilder: (context, index) {
              final examResult = filteredExams[index];
              double percentage =
                  (examResult["correctAnswers"] / examResult["totalQuestions"]);
              double roundedPercentage =
                  double.parse((percentage).toStringAsFixed(1));
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // controller.resetExam();
                    // controller.setUnitQuestions(examResult["questions"]);
                    // Get.to(() => const PreExam());
                  },
                  child: SizedBox(
                    height: 100,
                    child: Card(
                      color: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // const CircleAvatar(),
                            CircularPercentIndicator(
                              radius: 30.0,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 5.0,
                              percent: roundedPercentage,
                              center: Text("${roundedPercentage * 100}%"),
                              progressColor: (examResult["correctAnswers"] /
                                          examResult["totalQuestions"]) >
                                      0.5
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (examResult["correctAnswers"] /
                                              examResult["totalQuestions"]) >
                                          0.5
                                      ? Container(
                                          decoration: const BoxDecoration(
                                              color: AppColors.successBoxColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text("Passed",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .successColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14))))
                                      : Container(
                                          decoration: const BoxDecoration(
                                              color: AppColors.errorBoxColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text("Failed",
                                                style: TextStyle(
                                                    color: AppColors.errorColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14)),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.5),
                                    child: Text(
                                      "${examResult["examName"]}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "On: ${DateFormat('yyyy-MM-dd').format(examResult["date"].toDate())}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  "${examResult["points"]} points",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Color(0xFF743089),
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
        );
      },
    );
  }
}

class SubjectsLabelsData {
  String labelName;
  IconData icon;
  String routePath;

  SubjectsLabelsData(this.labelName, this.icon, this.routePath);
}
