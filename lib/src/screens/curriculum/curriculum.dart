import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/curriculum_controller.dart';
import 'package:falih/src/controller/subjects_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/src/screens/subject_page/subject_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Curriculum extends StatelessWidget {
  Curriculum({super.key});

  final CurriculumController controller = Get.put(CurriculumController());
  final SubjectsController subjectController = Get.put(SubjectsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.backgroundImageOfAuth),
            fit: BoxFit.cover,
            opacity: .2,
          ),
        ),
        child: Obx(() {
          // show subjects as grid
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 2.w,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 3),
            ),
            itemCount: controller.subjects.length,
            itemBuilder: (context, index) {
              final subject = controller.subjects[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // navigate to the subject page
                    subjectController.name.value = subject['name'];
                    subjectController.color = subject['color'];
                    subjectController.icon_path = subject['icon'];
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SubjectPage(),
                    ));
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
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
