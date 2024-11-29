import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatelessWidget {
  final void Function()? funtion;

  const NextButton({
    super.key,
    required this.funtion,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      height: 50.h,
      minWidth: 300.w,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: funtion,
      child: Text(
        S.of(context).next,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
            color: AppColors.mainColor),
      ),
    );
  }
}
