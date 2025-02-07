import 'package:falih/generated/l10n.dart';
import 'package:falih/src/controller/subjects_controller.dart';
import 'package:falih/src/screens/subject_page/subject_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/sizes.dart';
import '../../config/themes.dart';
import '../../controller/user_controller.dart';

class CurriculumPage extends StatelessWidget {
  CurriculumPage({super.key});

  final UserController userController = Get.put(UserController());
  final SubjectsController subjectController = Get.put(SubjectsController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var user = userController.user.value;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Obx(() => user == null
          ? Expanded(
              child: Center(
                child: Text(
                  "${S.of(context).user_data_not_available}.",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value:
                            "${S.of(context).grade}: ${subjectController.curriculumGrade}",
                        onChanged: (String? newValue) {
                          subjectController
                              .changeCurriculumGrade(newValue!.split(" ")[1]);
                        },
                        items: [
                          "${S.of(context).grade}: 9",
                          "${S.of(context).grade}: 12"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value:
                            "${S.of(context).hint_text_department}: ${subjectController.curriculumDepartment}",
                        onChanged: (String? newValue) {
                          subjectController.changeCurriculumDepartment(
                              newValue!.split(" ")[1]);
                        },
                        items: [
                          "${S.of(context).hint_text_department}: En",
                          "${S.of(context).hint_text_department}: Ar"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: SizeConfig.screenHeight! * 0.16,
                        mainAxisSpacing: SizeConfig.screenHeight! * 0.013,
                        crossAxisSpacing: SizeConfig.screenWidth! * 0.03,
                        childAspectRatio: SizeConfig.screenWidth! /
                            (SizeConfig.screenHeight! / 1.4),
                      ),
                      itemCount: subjectController.subjects.length,
                      itemBuilder: (context, index) {
                        final subject = subjectController.subjects[index];
                        return GestureDetector(
                          onTap: () {
                            subjectController.selectedIndex.value = 0;
                            subjectController.selectedSectionIndex.value = 0;
                            subjectController.id.value = subject['id'];
                            subjectController.name.value = subject['name'];
                            subjectController.color = subject['color'];
                            subjectController.iconPath = subject['icon'];
                            Get.to(() => SubjectPage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: subject['color'],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: SizeConfig.screenWidth! * 0.15,
                                  child: Image.asset(
                                    subject['icon'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  subject['name'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
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
            )),
    );
  }
}
