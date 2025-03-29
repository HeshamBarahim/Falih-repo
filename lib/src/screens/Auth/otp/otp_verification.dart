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

  final OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            S.of(context).otp,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.offAllNamed("login");
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return otpController.isSending.value
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
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
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.01,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          S.of(context).explaination_text,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            otpController.phoneNo.value,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Form(
                          child: OtpPinPut(),
                        ),
                        Obx(() => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight! * 0.01),
                              child: Text(
                                '${otpController.resendTimeout.value}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.current.didnt_send_ver_code,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Obx(() => TextButton(
                                  onPressed: otpController.canResendOtp.value
                                      ? () {
                                          otpController.resendOtp();
                                        }
                                      : null,
                                  child: Text(
                                    S.current.resend_code,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color:
                                              otpController.canResendOtp.value
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
