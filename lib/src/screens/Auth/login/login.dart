import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/login_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/signup/signup.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';
import '../../../controller/show_password_controller.dart';
import '../forgot_password/forgot_password.dart';
import '../widgets_auth/password_text_form_field.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    DateTime? lastBackPressTime;
    SizeConfig().init(context);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        DateTime now = DateTime.now();
        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
          lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.04,
                vertical: SizeConfig.screenHeight! * 0.01,
              ),
              content: Text(
                S.current.press_back_again,
                style: TextStyle(
                  fontSize: SizeConfig.screenHeight! * 0.015,
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(Images.backgroundImageOfAuth),
              fit: BoxFit.cover,
              opacity: 0.09,
            ),
          ),
          child: Form(
            key: loginController.loginFormKey,
            child: Padding(
              // padding: const EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight! * 0.02,
                  horizontal: SizeConfig.screenWidth! * 0.04),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                Images.falih,
                                width: SizeConfig.screenWidth! * 0.4,
                                height: SizeConfig.screenWidth! * 0.4,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight! * 0.02),
                              child: Text(
                                S.of(context).title_login,
                                style: const TextStyle(
                                  color: AppColors.darkMainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            CustomTextForm(
                              keyFormatter: true,
                              keyboardType: TextInputType.text,
                              myController: loginController.email,
                              validator: Helper.validatePhoneNumber,
                              labelText:
                                  S.of(context).hint_text_username_or_phone,
                              prefixIcon: Icon(
                                Icons.account_circle,
                                size: SizeConfig.screenHeight! * 0.03,
                              ),
                            ),
                            GetBuilder<ShowPasswordController>(
                              init: ShowPasswordController(),
                              builder: (controller) => CustomPasswordTextForm(
                                myController: loginController.password,
                                validator: Helper.validatePassword,
                                labelText: S.of(context).hint_text_password,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: SizeConfig.screenHeight! * 0.03,
                                ),
                                obscureText: controller.obText,
                                showPasswordFunction:
                                    controller.showPasswordFunction,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ForgotPassword());
                                },
                                child: Text(
                                  S.of(context).forget_password,
                                  style: const TextStyle(
                                    color: AppColors.warningColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GradientButton(
                      text: S.of(context).login,
                      height: SizeConfig.screenHeight! * 0.06,
                      width: double.infinity,
                      onClick: () async {
                        loginController.login(Get.context!);
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).not_registerd,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenHeight! * 0.018,
                          ),
                        ),
                        GradientText(
                          text: S.of(context).create_account,
                          route: () => Get.to(() => Signup()),
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
    );
  }
}
