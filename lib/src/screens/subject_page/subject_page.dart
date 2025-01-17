import 'package:falih/src/screens/subject_page/widgets/subjects_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/sizes.dart';
import '../../controller/subjects_controller.dart';

class SubjectPage extends StatelessWidget {
  SubjectPage({super.key});

  final SubjectsController subjectController = Get.put(SubjectsController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight! * 0.25,
            decoration: BoxDecoration(
              gradient: subjectController.color,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          subjectController.name.value.capitalizeFirst ?? "",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Image.asset(
                        subjectController.iconPath,
                        height: SizeConfig.screenHeight! * 0.10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SubjectsLabels(),
        ],
      ),
    );
  }
}
