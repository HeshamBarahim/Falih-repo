import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/screens/Auth/widgets_auth/otp_boxes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/resend_code_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';

class Otp extends StatelessWidget {
  Otp({
    super.key,
  });

  final FirebaseAuth auth = FirebaseAuth.instance;
  final otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String verificationId = Get.arguments['verificationId'];

    SizeConfig().init(context);
    return Stack(children: [
      Form(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: const AssetImage(
                Images.backgroundImageOfAuth,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                BlendMode.lighten,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.05,
            vertical: SizeConfig.screenHeight! * 0.02,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.screenHeight! * 0.05),
                  Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      Images.logoFalih,
                      width: SizeConfig.screenWidth! * 0.5,
                      height: SizeConfig.screenHeight! * 0.24,
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
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight! * 0.015,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      S.of(context).explaination_text,
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight! * 0.017,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '7777777',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.screenHeight! * 0.017,
                      color: AppColors.successColor,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.03,
                  ),
                  OtpBoxes(
                    otp: otp,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.05,
                  ),
                  Text(
                    '0:59',
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight! * 0.017,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const ResendCodeButton(),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.06,
                  ),
                  GradientButton(
                    text: S.of(context).submit,
                    height: SizeConfig.screenHeight! * 0.065,
                    width: double.infinity,
                    onClick: () async {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: otp.text,
                      );

                      await auth.signInWithCredential(credential);

                      if (auth.currentUser != null) {
                        Get.to(() => Login());
                      }
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).bottom_text_part1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenHeight! * 0.017,
                        ),
                      ),
                      GradientText(
                        text: S.of(context).bottom_text_part2,
                        route: '/login',
                        // route: Login(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
