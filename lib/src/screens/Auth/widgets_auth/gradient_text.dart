import 'package:flutter/material.dart';
import 'package:falih/src/config/themes.dart';
import 'package:get/get.dart';

class GradientText extends StatelessWidget {
  final String text;
  final String route;
  const GradientText({
    super.key,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushReplacementNamed(route);
        Get.toNamed(route);
      },
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 15.0,
            color: AppColors.successColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
