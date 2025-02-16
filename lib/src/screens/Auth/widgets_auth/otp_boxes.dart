import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../config/sizes.dart';
import '../../../config/themes.dart';
import '../../../controller/otp_controller.dart';

class OtpPinPut extends StatelessWidget {
  const OtpPinPut({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController =
        Get.find<OtpController>(); // Initialize the controller

    SizeConfig().init(context);
    return Directionality(
      textDirection: TextDirection.ltr, // Force LTR layout
      child: Pinput(
        controller: otpController.otpTextController,
        length: 6,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        onCompleted: (value) {
          otpController.verifyOtp(value);
        },
        defaultPinTheme: PinTheme(
          textStyle: TextStyle(
            color: AppColors.darkMainColor,
            fontSize: SizeConfig.screenHeight! * 0.03,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: AppColors.darkMainColor,
              width: SizeConfig.screenWidth! * 0.0024,
            ),
          ),
          height: SizeConfig.screenHeight! * 0.1,
        ),
      ),
    );
  }
}
