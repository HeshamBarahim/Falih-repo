import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onClick;

  const GradientButton(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: AppColors.mainColor),
      child: MaterialButton(
        height: 40.h,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        textColor: Colors.white,
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
    );
  }
}
