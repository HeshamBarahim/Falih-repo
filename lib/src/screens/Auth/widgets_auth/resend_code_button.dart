import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 50.h,
            width: 200.w,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.mainColor),
                borderRadius: BorderRadius.circular(25)),
            child: Center(
                child: Text(
              S.of(context).resend_code,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))));
  }
}
