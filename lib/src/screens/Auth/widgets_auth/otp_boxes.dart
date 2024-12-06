import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../config/sizes.dart';

class OtpBoxes extends StatelessWidget {
  final TextEditingController otp;

  const OtpBoxes({
    super.key,
    required this.otp,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
              width: SizeConfig.screenWidth! * 0.0024,
            )),
        height: SizeConfig.screenHeight! * 0.6,
        width: SizeConfig.screenWidth! * 0.6,
      ),
    ));
  }
}
