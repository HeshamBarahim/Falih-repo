import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/login_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // Initialize the controller
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Form(
        key: controller.loginFormKey,
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
                  Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      Images.logoFalih,
                      width: 200.w,
                      height: 200.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // welcome back title
                  Container(
                    margin: const EdgeInsets.only(right: 130),
                    child: Text(S.of(context).title_login,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Text Field of phone number
                  CustomTextForm(
                      myController: controller.email,
                      hintText: S.of(context).hint_text_phone,
                      prefixIcon: const Icon(Icons.phone_android),
                      validator: Helper.validatePhoneNumber),
                  // Text Field of the password
                  CustomTextForm(
                      hintText: S.of(context).hint_text_password,
                      prefixIcon: const Icon(Icons.lock),
                      myController: controller.password,
                      validator: Helper.validatePassword),
                  // Forget password
                  Container(
                    margin: const EdgeInsets.only(right: 190),
                    child: InkWell(
                        child: Text(S.of(context).forget_password,
                            style: const TextStyle(
                                color: AppColors.shadowColor,
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  // Login Button
                  GradientButton(
                      text: S.of(context).login,
                      height: 50.h,
                      width: double.infinity,
                      onClick: () {}),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).not_registerd,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GradientText(
                          text: S.of(context).create_account, route: '/signup')
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
