import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/exam_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../controller/subjects_controller.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../pre_exam/pre_exam.dart';

class SubjectsLabels extends StatelessWidget {
  SubjectsLabels({super.key});

  final SubjectsController subjectController = Get.put(SubjectsController());
  final ExamController controller = Get.put(ExamController());

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final List<SubjectsLabelsData> items = [
      SubjectsLabelsData(
          S.of(context).unit_exams, Icons.app_shortcut_sharp, ''),
      SubjectsLabelsData(
          S.of(context).exams, Icons.bookmarks_sharp, '/runExam'),
      SubjectsLabelsData(S.of(context).results, Icons.stacked_line_chart, ''),
    ];
    return Expanded(
      child: Transform.translate(
        offset: const Offset(0, -45), // Push up by 10px
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  items.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        // Update selected index using the controller
                        if (index == 1) {
                          controller.examType.value = "FinalExam";
                          controller.setExamQuestions();
                          Get.to(() => const PreExam());
                          return;
                        }
                        subjectController.changeSelectedIndex(index);
                      },
                      child: Obx(() => Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: subjectController.selectedIndex.value ==
                                      index
                                  ? AppColors
                                      .choicesColor // Highlight selected item
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Icon(
                                //   items[index].icon,
                                //   color: AppColors.mainColor,
                                // ),
                                // const SizedBox(
                                //   width: 5,
                                // ),
                                Text(
                                  items[index].labelName,
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
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

            // Content based on the selected index
            Obx(() {
              if (subjectController.selectedIndex.value == 0) {
                return _buildUnitsExams(firestore);
                // } else if (subjectController.selectedIndex.value == 1) {
                //   Get.to(() => const PreExam());
                //   return Container();
                // return _buildExamsContent();
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

  // Function to build content for "unit_exams"
  Widget _buildUnitsExams(FirebaseFirestore firestore) {
    controller.examType.value = "UnitExam";
    var subjectName = subjectController.name.value;
    if (subjectName == "Islamic Education") {
      subjectName = "islamic";
    } else if (subjectName == "Quran Kareem") {
      subjectName = "quran";
    } else if (subjectName == "Arabic Language") {
      subjectName = "arabic";
    } else if (subjectName == "English Language") {
      subjectName = "english";
    }

    var user = UserController.instance.user.value;
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
          return const Expanded(
              child: Center(child: Text('Still no chapters')));
        }

        final subjectData = snapshot.data!.data() as Map<String, dynamic>;
        final units = subjectData['units'];
        controller.units = units;

        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: units.length,
            itemBuilder: (context, index) {
              final unit = units[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    controller.resetExam();
                    controller.setUnitQuestions(unit["questions"]);
                    Get.to(() => const PreExam());
                  },
                  child: Card(
                    color: const Color(0xFFFBF7FC),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const CircleAvatar(),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${unit["questions"].length} Questions",
                            style: const TextStyle(
                              color: AppColors.successColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
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

  // Placeholder content for "exams"
  // void Widget _buildExamsContent() {
  //   Get.to(() => const PreExam());
  //   // return Center(
  //   //   child: Text("Exams content here"),
  //   // );
  // }

  // Placeholder content for "results"
  Widget _buildResultsContent(FirebaseFirestore firestore) {
    var subjectName = subjectController.name;
    if (subjectName.value == "Islamic Education") {
      subjectName.value = "Islamic";
    } else if (subjectName.value == "Quran Kareem") {
      subjectName.value = "Quran";
    } else if (subjectName.value == "Arabic Language") {
      subjectName.value = "Arabic";
    } else if (subjectName.value == "English Language") {
      subjectName.value = "English";
    }

    return FutureBuilder<UserModel>(
      future: UserRepository.instance.getUserDetails(),
      // Fetch user details asynchronously
      builder: (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (userSnapshot.hasError) {
          return Expanded(
              child: Center(child: Text('Error: ${userSnapshot.error}')));
        } else if (!userSnapshot.hasData) {
          return const Expanded(
              child: Center(child: Text('User is not authenticated')));
        }

        UserModel user = userSnapshot.data!;
        return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: firestore
              .collection('exams')
              .doc(user.id)
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
              return data["examName"] == subjectName.value;
            }).toList();
            if (filteredExams.isEmpty) {
              return const Expanded(
                  child: Center(child: Text('No exams yet, go and take one')));
            }

            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: filteredExams.length,
                itemBuilder: (context, index) {
                  final examResult = examResults[index];
                  double percentage = (examResult["correctAnswers"] /
                      examResult["totalQuestions"]);
                  double roundedPercentage =
                      double.parse((percentage).toStringAsFixed(1));
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                            padding: EdgeInsets.symmetric(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      (examResult["correctAnswers"] /
                                                  examResult[
                                                      "totalQuestions"]) >
                                              0.5
                                          ? Container(
                                              decoration: const BoxDecoration(
                                                  color:
                                                      AppColors.successBoxColor,
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                  color:
                                                      AppColors.errorBoxColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text("Failed",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .errorColor,
                                                        fontWeight:
                                                            FontWeight.w500,
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
