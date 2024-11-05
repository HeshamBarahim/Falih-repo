import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/exam_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/subjects_controller.dart';
import '../../pre_exam/pre_exam.dart';

class SubjectsLabels extends StatelessWidget {

  SubjectsLabels({super.key});

  final SubjectsController subjectController = Get.put(SubjectsController());

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              items.length,
              (index) {
                return InkWell(
                  onTap: () {
                    // Update selected index using the controller
                    subjectController.changeSelectedIndex(index);
                  },
                  child: Obx(() => Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: subjectController.selectedIndex.value == index
                              ? Colors.grey[300] // Highlight selected item
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
                              style: const TextStyle(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
          ),

          // Content based on the selected index
          Obx(() {
            if (subjectController.selectedIndex.value == 0) {
              return _buildUnitsExams(firestore);
            } else if (subjectController.selectedIndex.value == 1) {
              return _buildExamsContent();
            } else {
              return _buildResultsContent();
            }
          })
        ],
      ),
    );
  }

  // Function to build content for "unit_exams"
  Widget _buildUnitsExams(FirebaseFirestore firestore) {
    var subjectName = subjectController.name.value;
    if (subjectName == "Islamic Education") {
      subjectName = "islamic";
    } else if (subjectName == "Quram Kareem") {
      subjectName = "quran";
    } else if (subjectName == "Arabic Language") {
      subjectName = "arabic";
    } else if (subjectName == "English Language") {
      subjectName = "english";
    }

    print("${subjectName.toLowerCase()}_9");
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: firestore
          .collection('subjects_ar_9')
          .doc("${subjectName.toLowerCase()}_9")
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            !snapshot.data!.exists ||
            snapshot.data!.data()!.isEmpty) {
          return const Center(child: Text('No data found'));
        }

        print(snapshot.data!.data()?.isEmpty);
        final subjectData = snapshot.data!.data() as Map<String, dynamic>;
        final units = subjectData['units'];

        return Expanded(
          child: ListView.builder(
            itemCount: units.length,
            itemBuilder: (context, index) {
              final unit = units[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    final ExamController controller = Get.put(ExamController());
                    controller.resetExam();
                    controller.setQuestions(unit["questions"]);
                    Get.to(() => const PreExam());
                  },
                  child: Card(
                    color: const Color(0xFFFBF7FC),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                  unit["unitName"],
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
                              color: Color(0xFF3CD797),
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
  Widget _buildExamsContent() {
    return Center(
      child: Text("Exams content here"),
    );
  }

  // Placeholder content for "results"
  Widget _buildResultsContent() {
    return Center(
      child: Text("Results content here"),
    );
  }
}

class SubjectsLabelsData {
  String labelName;
  IconData icon;
  String routePath;

  SubjectsLabelsData(this.labelName, this.icon, this.routePath);
}
