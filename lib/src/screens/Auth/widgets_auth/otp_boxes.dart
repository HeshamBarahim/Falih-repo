import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpBoxes extends StatelessWidget {
  final TextEditingController otp;

  const OtpBoxes({
    super.key,
    required this.otp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Pinput(
      controller: otp,
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      defaultPinTheme: PinTheme(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border:
                  Border.all(color: Colors.black.withOpacity(0.5), width: 1)),
          height: 60.h,
          width: 60.w),
    ));
  }
}
