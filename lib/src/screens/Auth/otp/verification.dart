import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/otp_boxes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/resend_code_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:get/get.dart';

class Otp extends StatelessWidget {
  Otp({
    super.key,
  });
  final FirebaseAuth auth = FirebaseAuth.instance;
  final otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String verificationId = Get.arguments['verificationId'];
    return Stack(children: [
      Form(
        // Container for background image
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
                      BlendMode.lighten))),
          padding: const EdgeInsets.all(20),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // logo of falih
                  Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      Images.logoFalih,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // otp text
                  Text(
                    S.of(context).otp,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // explaination text for send otp
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      S.of(context).explaination_text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // number the code has been sent
                  const Text(
                    '7777777',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.successColor),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // otp boxes fields
                  OtpBoxes(
                    otp: otp,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // timing
                  const Text(
                    '0:59',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  // resend button
                  const ResendCodeButton(),
                  const SizedBox(
                    height: 50,
                  ),
                  // Submit button
                  GradientButton(
                      text: S.of(context).submit,
                      height: 55,
                      width: double.infinity,
                      onClick: () async {
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: otp.text);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);

                        if (auth.currentUser != null) {
                          Get.to(() => Login());
                        }
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                  // last text below button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).bottom_text_part1,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GradientText(
                          text: S.of(context).bottom_text_part2,
                          route: '/login')
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
