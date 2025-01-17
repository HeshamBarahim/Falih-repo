// Subjects_Label
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/controller/exam_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../generated/l10n.dart';
import '../../../config/themes.dart';
import '../../../controller/subjects_controller.dart';
import '../../pre_exam/pre_exam.dart';

class SubjectsLabels extends StatelessWidget {
  final SubjectsController subjectController = Get.put(SubjectsController());
  final ExamController examController = Get.put(ExamController());

  SubjectsLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final screenHeight = MediaQuery.of(context).size.height;

    final List<SubjectsLabelsData> items = [
      SubjectsLabelsData(
          S.of(context).unit_exams, Icons.app_shortcut_sharp, ''),
      SubjectsLabelsData(
          S.of(context).exams, Icons.bookmarks_sharp, '/runExam'),
      SubjectsLabelsData(S.of(context).results, Icons.stacked_line_chart, ''),
    ];

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(
              items.length,
              (index) {
                return Expanded(
                  child: InkWell(
                    onTap: () {
                      if (index == 1) {
                        displayFinalExam(context);
                        return;
                      }
                      subjectController.changeSelectedIndex(index);
                    },
                    child: Obx(
                      () => Container(
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color:
                                  subjectController.selectedIndex.value == index
                                      ? AppColors.darkMainColor
                                      : AppColors.lightenMainColor,
                              width: 2.0,
                            ),
                          ),
                          color: subjectController.selectedIndex.value == index
                              ? AppColors.choicesColor
                              : Colors.white,
                          // borderRadius: BorderRadius.circular(4),
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
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          subjectController.subjectSections[subjectController
                      .curriculumGrade.value]?[subjectController.id.value] !=
                  null
              ? Row(
                  children: [
                    Expanded(
                      child: Row(children: [
                        // List.generate widgets
                        ...List.generate(
                          subjectController
                                  .subjectSections[subjectController
                                      .curriculumGrade
                                      .value]?[subjectController.id.value]!
                                  .length ??
                              0,
                          (index) {
                            return Expanded(
                              flex: 1, // Same flex for all items
                              child: InkWell(
                                onTap: () {
                                  subjectController
                                      .changeSelectedSectionIndex(index);
                                },
                                child: Obx(() => Container(
                                      height: screenHeight * 0.06,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: subjectController
                                                        .selectedSectionIndex
                                                        .value ==
                                                    index
                                                ? AppColors.darkMainColor
                                                : AppColors.lightenMainColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        color: subjectController
                                                    .selectedSectionIndex
                                                    .value ==
                                                index
                                            ? AppColors.choicesColor
                                            : Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            subjectController
                                                    .subjectSections[
                                                        subjectController
                                                            .curriculumGrade
                                                            .value]?[
                                                        subjectController
                                                            .id.value]![index]
                                                    .capitalizeFirst ??
                                                "",
                                            style: TextStyle(
                                              color: AppColors.darkMainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenHeight * 0.015,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                        ),
                        // Button with the same size as the list items
                        Obx(() => subjectController.selectedIndex.value == 2
                            ? Expanded(
                                flex: 1, // Same flex as the list items
                                child: InkWell(
                                  onTap: () {
                                    subjectController
                                        .changeSelectedSectionIndex(
                                            subjectController
                                                    .subjectSections[
                                                        subjectController
                                                            .curriculumGrade
                                                            .value]?[
                                                        subjectController
                                                            .id.value]!
                                                    .length ??
                                                0);
                                  },
                                  child: Obx(() => Container(
                                        height: screenHeight * 0.06,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: subjectController
                                                          .selectedSectionIndex
                                                          .value ==
                                                      subjectController
                                                          .subjectSections[
                                                              subjectController
                                                                  .curriculumGrade
                                                                  .value]?[
                                                              subjectController
                                                                  .id.value]!
                                                          .length
                                                  ? AppColors.darkMainColor
                                                  : AppColors.lightenMainColor,
                                              width: 2.0,
                                            ),
                                          ),
                                          color: subjectController
                                                      .selectedSectionIndex
                                                      .value ==
                                                  subjectController
                                                      .subjectSections[
                                                          subjectController
                                                              .curriculumGrade
                                                              .value]?[
                                                          subjectController
                                                              .id.value]!
                                                      .length
                                              ? AppColors.choicesColor
                                              : Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "All",
                                              style: TextStyle(
                                                color: AppColors.darkMainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.015,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              )
                            : Container())
                      ]),
                    ),
                  ],
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
    );
  }

  Widget _buildUnitsExams(FirebaseFirestore firestore, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    subjectController
        .subjectNameFetcher(subjectController.selectedSectionIndex.value);
    examController.examName.value = subjectController.name.value;
    examController.examType.value = "UnitExam";

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: firestore
            .collection(
                'subjects_${subjectController.curriculumDepartment.value.toLowerCase()}_${subjectController.curriculumGrade.value.toLowerCase()}')
            .doc(
                "${subjectController.name.value.toLowerCase()}_${subjectController.curriculumGrade.value.toLowerCase()}")
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
          examController.units = units;

          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: units.length, // Example count
              itemBuilder: (context, index) {
                final unit = units[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      examController.resetExam();
                      examController.setUnitQuestions(unit["questions"]);
                      Get.to(() => const PreExam());
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: AppColors.moreLightenMainColor,
                      elevation: 10,
                      shadowColor: AppColors.darkMainColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: MediaQuery.of(context).size.width * 0.12,
                              // Ensure it's a perfect circle
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.darkMainColor,
                              ),
                              alignment: Alignment.center,
                              // Centers the text
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors
                                      .secondaryColor, // Add contrasting color for visibility
                                ),
                              ),
                            ),
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
                            const Text(
                              "10 Questions",
                              style: TextStyle(
                                color: AppColors.shadowColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: screenHeight * 0.025,
                              color: AppColors.darkMainColor,
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
    subjectController
        .subjectNameFetcher(subjectController.selectedSectionIndex.value);

    // return Text("data");
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: firestore
          .collection('exams')
          .doc(subjectController.user.value?.id)
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
          final data = doc.data();
          final examName = data["examName"].toString().toLowerCase();
          if (subjectController.name.value == "All") {
            if (subjectController.subjectSections[subjectController
                    .curriculumGrade.value]![subjectController.id.value]!
                .contains(examName)) {
              return true;
            } else if ([subjectController.id.value].contains(examName)) {
              return true;
            }
          }
          return data["examName"].toString().toLowerCase() ==
              subjectController.name.value;
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    color: AppColors.moreLightenMainColor,
                    elevation: 10,
                    shadowColor: AppColors.darkMainColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.5),
                                  child: Text(
                                    "${examResult["examName"].toString().capitalizeFirst}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
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
                                                    color:
                                                        AppColors.successColor,
                                                    fontWeight: FontWeight.w500,
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
                                  height: 5,
                                ),
                                Text(
                                  "${examResult["examType"]}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
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
                                "${S.of(context).correct_answers}: ${examResult["correctAnswers"]} / ${examResult["totalQuestions"]}",
                                style: const TextStyle(
                                  color: AppColors.shadowColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${S.of(context).on}: ${DateFormat('yyyy-MM-dd').format(examResult["date"].toDate())}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                "${examResult["points"]} ${S.of(context).points}",
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
              );
            },
          ),
        );
      },
    );
  }

  void displayFinalExam(context) {
    if (subjectController.isSubjectWithSections()) {
      int localSelectedIndex = subjectController.selectedSectionIndex.value;
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child:
              StatefulBuilder(builder: (BuildContext _, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Choose any section or select all",
                      style: TextStyle(
                        color: AppColors.darkMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              subjectController
                                      .subjectSections[subjectController
                                          .curriculumGrade
                                          .value]![subjectController.id.value]
                                      ?.length ??
                                  0, (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  localSelectedIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: localSelectedIndex == index
                                        ? AppColors.mainColor.withOpacity(0.50)
                                        : AppColors.lightenMainColor
                                            .withOpacity(0.50),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      subjectController
                                              .subjectSections[subjectController
                                                      .curriculumGrade.value]![
                                                  subjectController
                                                      .id.value]![index]
                                              .capitalizeFirst ??
                                          "",
                                      style: const TextStyle(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              localSelectedIndex = -1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: localSelectedIndex == -1
                                    ? AppColors.mainColor.withOpacity(0.50)
                                    : AppColors.lightenMainColor
                                        .withOpacity(0.50),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        await subjectController
                            .startFinalExam(localSelectedIndex);
                        Navigator.pop(_);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: AppColors
                                .mainColor, // Border color consistent with the theme
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.darkMainColor,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.lightenMainColor.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          S.of(context).start_exam,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.lightenMainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    } else {
      examController.examType.value = "FinalExam";
      examController.setExamQuestions();
      Get.to(() => const PreExam());
    }
  }
}

class SubjectsLabelsData {
  String labelName;
  IconData icon;
  String routePath;

  SubjectsLabelsData(this.labelName, this.icon, this.routePath);
}
