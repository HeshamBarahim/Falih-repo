import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/config/images.dart';
import 'package:get/get.dart';
import 'package:falih/src/controller/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // Initialize the controller
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: controller.loginFormKey,
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
            padding: const EdgeInsets.all(20),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Image.asset(
                              Images.logoFalih,
                              width: 150.w,
                              height: 150.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                S.of(context).title_login,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                ),
                              ),
                            ),
                          ),
                          // Text Field of phone number
                          CustomTextForm(
                            myController: controller.email,
                            hintText: S.of(context).hint_text_phone,
                            prefixIcon: const Icon(Icons.phone_android),
                            validator: Helper.validatePhoneNumber,
                          ),
                          // Text Field of the password
                          CustomTextForm(
                            hintText: S.of(context).hint_text_password,
                            prefixIcon: const Icon(Icons.lock),
                            myController: controller.password,
                            validator: Helper.validatePassword,
                          ),
                          // Forget password
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: InkWell(
                                child: Text(
                                  S.of(context).forget_password,
                                  style: TextStyle(
                                    color: AppColors.warningColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .20),
                      Column(
                        children: [
                          GradientButton(
                            text: S.of(context).login,
                            height: 50.h,
                            width: double.infinity,
                            onClick: () {
                              controller.login();
                            },
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).not_registerd,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                ),
                              ),
                              GradientText(
                                text: S.of(context).create_account,
                                route: '/signup',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
