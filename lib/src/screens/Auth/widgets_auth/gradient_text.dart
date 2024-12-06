import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';

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
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushReplacementNamed(route);
        Get.toNamed(route);
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.036,
            color: AppColors.successColor,
            fontWeight: 
            FontWeight.bold),
      ),
    );
  }
}
