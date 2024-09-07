import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class Curriculum extends StatefulWidget {
  const Curriculum({super.key});

  @override
  State<Curriculum> createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> subjects = [
      {
        'name': S.of(context).subject_one,
        'color': AppColors.quranColor,
        'icon': Images.quranIcon
      },
      {
        'name': S.of(context).subject_two,
        'color': AppColors.islamicColor,
        'icon': Images.islamicIcon
      },
      {
        'name': S.of(context).subject_three,
        'color': AppColors.arabicColor,
        'icon': Images.arabicIcon
      },
      {
        'name': S.of(context).subject_four,
        'color': AppColors.englisColor,
        'icon': Images.englishIcon
      },
      {
        'name': S.of(context).subject_five,
        'color': AppColors.chemistyColor,
        'icon': Images.chemistryIcon
      },
      {
        'name': S.of(context).subject_six,
        'color': AppColors.physicsColor,
        'icon': Images.physicsIcon
      },
      {
        'name': S.of(context).subject_seven,
        'color': AppColors.biologyColor,
        'icon': Images.biologyIcon
      },
      {
        'name': S.of(context).subject_eight,
        'color': AppColors.mathColor,
        'icon': Images.mathIcon
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0, // Vertical spacing between boxes
            crossAxisSpacing: 5.0, // Horizontal spacing between boxes
            childAspectRatio:
                1.6, // Controls the aspect ratio of the grid items
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 120,
                  decoration: BoxDecoration(
                      gradient: subjects[index]['color'],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          subjects[index]['icon'],
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            subjects[index]['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
