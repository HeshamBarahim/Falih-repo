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

import '../../../config/sizes.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.05,
                vertical: SizeConfig.screenHeight! * 0.0243),
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
                              width: SizeConfig.screenWidth! * 0.46,
                              height: SizeConfig.screenHeight! * 0.18,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth! * 0.02,
                                  vertical: SizeConfig.screenHeight! * 0.00975),
                              child: Text(
                                S.of(context).title_login,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenHeight! * 0.03,
                                ),
                              ),
                            ),
                          ),
                          CustomTextForm(
                            myController: controller.email,
                            hintText: S.of(context).hint_text_phone,
                            prefixIcon: Icon(
                              Icons.phone_android,
                              size: SizeConfig.screenHeight! * 0.03,
                            ),
                            validator: Helper.validatePhoneNumber,
                          ),
                          CustomTextForm(
                            hintText: S.of(context).hint_text_password,
                            prefixIcon: Icon(
                              Icons.lock,
                              size: SizeConfig.screenHeight! * 0.03,
                            ),
                            myController: controller.password,
                            validator: Helper.validatePassword,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth! * 0.02,
                                  vertical: SizeConfig.screenHeight! * 0.00975),
                              child: InkWell(
                                child: Text(
                                  S.of(context).forget_password,
                                  style: TextStyle(
                                    color: AppColors.warningColor,
                                    fontSize: SizeConfig.screenHeight! * 0.018,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.15),
                      Column(
                        children: [
                          GradientButton(
                            text: S.of(context).login,
                            height: SizeConfig.screenHeight! * 0.06,
                            width: double.infinity,
                            onClick: () {
                              controller.login();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.03,
                          ),
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
