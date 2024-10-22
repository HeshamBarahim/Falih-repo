import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectsLabels extends StatelessWidget {
  final String name;
  final LinearGradient color;

  SubjectsLabels({super.key, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    final List<SubjectsLabelsData> items = [
      SubjectsLabelsData(
          S.of(context).exams, Icons.bookmarks_sharp, '/preExam'),
      SubjectsLabelsData(S.of(context).results, Icons.stacked_line_chart, ''),
      SubjectsLabelsData(
          S.of(context).practice_test, Icons.app_shortcut_sharp, ''),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        items.length,
        (index) {
          return InkWell(
            onTap: () {
              Get.toNamed(items[index].routePath, arguments: {
                'color': color,
                'name': name,
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    items[index].icon,
                    color: AppColors.mainColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    items[index].labelName,
                    style: const TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SubjectsLabelsData {
  String labelName;
  IconData icon;
  String routePath;

  SubjectsLabelsData(this.labelName, this.icon, this.routePath);
}
