import 'package:falih/src/screens/subject_page/widgets/subjects_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/subjects_controller.dart';

class SubjectPage extends StatelessWidget {
  SubjectPage({super.key});

  final SubjectsController subjectController = Get.put(SubjectsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // box who has the subject name and image
          Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: BoxDecoration(
                gradient: subjectController.color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // show image and subject name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Text(
                            subjectController.name.value,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      Image.asset(
                        subjectController.icon_path,
                        // color: Colors.white,
                        height: 150,
                        width: 150,
                      )
                    ],
                  ),
                ],
              )),
          // const SizedBox(
          //   height: 20,
          // ),
          SubjectsLabels(),
        ],
      ),
    );
  }
}
