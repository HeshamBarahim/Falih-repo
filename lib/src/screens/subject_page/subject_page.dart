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
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.05),
            height: SizeConfig.screenHeight! * 0.33,
            decoration: BoxDecoration(
              gradient: subjectController.color,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        subjectController.name.value,
                        style: TextStyle(
                          fontSize: SizeConfig.screenWidth! * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Image.asset(
                      subjectController.icon_path,
                      height: SizeConfig.screenHeight! * 0.18,
                      width: SizeConfig.screenWidth! * 0.3,
                    ),
                  ],
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
