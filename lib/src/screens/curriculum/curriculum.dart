import 'package:falih/src/controller/curriculum_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/src/screens/subject_page/subject_page.dart';

class Curriculum extends StatelessWidget {
  Curriculum({super.key});
  final CurriculumController controller = Get.put(CurriculumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        // show subjects as grid
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1.6,
          ),
          itemCount: controller.subjects.length,
          itemBuilder: (context, index) {
            final subject = controller.subjects[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // navigate to the subject page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SubjectPage(
                      color: subject['color'],
                      name: subject['name'],
                      icon: subject['icon'],
                    ),
                  ));
                },
                // show each box with its color and text
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 120,
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
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            subject['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
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
    );
  }
}
