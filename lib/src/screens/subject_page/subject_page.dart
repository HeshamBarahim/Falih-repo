import 'package:falih/src/screens/subject_page/widgets/subjects_label.dart';
import 'package:flutter/material.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage(
      {super.key, required this.name, required this.color, required this.icon});

  final String name;
  final LinearGradient color;
  final String icon;

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
                gradient: color,
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
                        name,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      Image.asset(
                        icon,
                        // color: Colors.white,
                        height: 150,
                        width: 150,
                      )
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          SubjectsLabels(
            color: color,
            name: name,
          ),
        ],
      ),
    );
  }
}
