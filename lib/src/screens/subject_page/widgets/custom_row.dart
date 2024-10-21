import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/pre_exam/pre_exam.dart';
import 'package:falih/src/screens/run_exam/run_exam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRow extends StatelessWidget {
  final String name;
  final LinearGradient color;
  const CustomRow({super.key, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              const Icon(
                Icons.stacked_line_chart,
                color: AppColors.mainColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                S.of(context).statistics,
                style: const TextStyle(
                    color: AppColors.mainColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              const Icon(Icons.app_shortcut_sharp, color: AppColors.mainColor),
              const SizedBox(
                width: 5,
              ),
              Text(
                S.of(context).chapters,
                style: const TextStyle(
                    color: AppColors.mainColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            // Get.toNamed('/runExam');
            Get.to(const PreExam(), arguments: {
              'color': color,
              'name': name,
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmarks_sharp,
                  color: AppColors.mainColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  S.of(context).exams,
                  style: const TextStyle(
                      color: AppColors.mainColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
