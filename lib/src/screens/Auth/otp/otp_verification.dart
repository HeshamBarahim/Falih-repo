import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';
import '../../../controller/otp_controller.dart';
import '../widgets_auth/otp_boxes.dart';

class OTPVerification extends StatelessWidget {
  OTPVerification({super.key});

  final otpController = Get.find<OtpController>(); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkMainColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return otpController.isSending.value
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    // Allow scrolling if content exceeds screen size
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            Images.falih,
                            width: SizeConfig.screenWidth! * 0.4,
                            height: SizeConfig.screenWidth! * 0.4,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          S.of(context).otp,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: SizeConfig.screenHeight! * 0.025,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.01,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          S.of(context).explaination_text,
                          style: TextStyle(
                            fontSize: SizeConfig.screenHeight! * 0.017,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            otpController.phoneNo.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.successColor,
                            ),
                          ),
                        ),
                        const Form(
                          child: OtpPinPut(),
                        ),
                        Obx(() => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight! * 0.01),
                              child: Text(
                                '${otpController.resendTimeout.value} seconds',
                                style: TextStyle(
                                  fontSize: SizeConfig.screenHeight! * 0.017,
                                  color: AppColors.darkMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Didn\'t receive OTP?',
                              style: TextStyle(color: AppColors.mainColor),
                            ),
                            Obx(() => TextButton(
                                  onPressed: otpController.canResendOtp.value
                                      ? () {
                                          otpController.resendOtp();
                                        }
                                      : null,
                                  child: Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                      color: otpController.canResendOtp.value
                                          ? AppColors.mainColor
                                          : Colors.grey,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
          }),
        ));
  }
}
