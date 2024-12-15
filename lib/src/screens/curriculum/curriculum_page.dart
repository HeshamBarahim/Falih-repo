import 'package:falih/src/controller/curriculum_controller.dart';
import 'package:falih/src/controller/subjects_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/subject_page/subject_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CurriculumPage extends StatelessWidget {
  CurriculumPage({super.key});

  final CurriculumController controller = Get.put(CurriculumController());
  final SubjectsController subjectController = Get.put(SubjectsController());
  final authRepo = AuthenticationRepository.instance;
  final UserController userController = UserController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
      child: Column(
        children: [
          // Add a widget above the GridView
          Obx(
            () => userController.currentUser == null
                ? const Text("User data not available.")
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Class: ${userController.currentUser!.selectedGrade}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${userController.currentUser!.selectedDepartment}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.w,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 3),
              ),
              itemCount: controller.subjects.length,
              itemBuilder: (context, index) {
                final subject = controller.subjects[index];
                return GestureDetector(
                  onTap: () {
                    // navigate to the subject page
                    subjectController.name.value = subject['name'];
                    subjectController.color = subject['color'];
                    subjectController.icon_path = subject['icon'];
                    Get.to(() => SubjectPage());
                  },
                  // show each box with its color and text
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: subject['color'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // to center the content name & image
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            subject['icon'],
                            height: 30.h,
                            width: 30.w,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: Text(
                              subject['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
