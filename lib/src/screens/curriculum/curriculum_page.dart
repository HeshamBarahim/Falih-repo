import 'package:falih/generated/l10n.dart';
import 'package:falih/src/controller/curriculum_controller.dart';
import 'package:falih/src/controller/subjects_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/subject_page/subject_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/sizes.dart';

class CurriculumPage extends StatelessWidget {
  CurriculumPage({super.key});

  final CurriculumController controller = Get.put(CurriculumController());
  final SubjectsController subjectController = Get.put(SubjectsController());
  final authRepo = AuthenticationRepository.instance;
  final UserController userController = UserController.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth! * 0.04,
      ),
      child: Column(
        children: [
          Obx(
            () => userController.currentUser == null
                ? Text(
                    "${S.of(context).user_data_not_available}.",
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth! * 0.04,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${S.of(context).grade}: ${userController.currentUser!.selectedGrade}",
                          style: TextStyle(
                            fontSize: SizeConfig.screenWidth! * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${userController.currentUser!.selectedDepartment}',
                          style: TextStyle(
                            fontSize: SizeConfig.screenWidth! * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 0.097,
                  vertical: SizeConfig.screenHeight! * 0.0059),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: SizeConfig.screenHeight! * 0.16,
                  mainAxisSpacing: SizeConfig.screenHeight! * 0.013,
                  crossAxisSpacing: SizeConfig.screenWidth! * 0.03,
                  childAspectRatio: SizeConfig.screenWidth! /
                      (SizeConfig.screenHeight! / 1.4),
                ),
                itemCount: controller.subjects.length,
                itemBuilder: (context, index) {
                  final subject = controller.subjects[index];
                  return GestureDetector(
                    onTap: () {
                      subjectController.name.value = subject['name'];
                      subjectController.color = subject['color'];
                      subjectController.iconPath = subject['icon'];
                      Get.to(() => SubjectPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: subject['color'],
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth! * 0.055),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth! * 0.165,
                            child: Image.asset(
                              subject['icon'],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            subject['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.screenWidth! * 0.039,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
