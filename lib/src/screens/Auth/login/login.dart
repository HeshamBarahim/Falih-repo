import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/signup/singup.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/config/images.dart';
import 'package:get/get.dart';
import 'package:falih/src/controller/login_controller.dart';
import '../../../config/sizes.dart';
import '../../../controller/loading_dialog_controller.dart';
import '../signup/signup_part1.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController loginController = Get.put(LoginController());
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  DateTime? lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
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
              content: const Text(
                'Press back again to exit The App',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Form(
              key: loginController.loginFormKey,
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
                                  Images.falih,
                                  width: SizeConfig.screenWidth! * 0.5,
                                  height: SizeConfig.screenHeight! * 0.2,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.screenWidth! * 0.02,
                                      vertical:
                                          SizeConfig.screenHeight! * 0.00975),
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
                                myController: loginController.email,
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
                                myController: loginController.password,
                                validator: Helper.validatePassword,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.screenWidth! * 0.02,
                                      vertical:
                                          SizeConfig.screenHeight! * 0.00975),
                                  child: InkWell(
                                    child: Text(
                                      S.of(context).forget_password,
                                      style: TextStyle(
                                        color: AppColors.warningColor,
                                        fontSize:
                                            SizeConfig.screenHeight! * 0.018,
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
                                  loginController.login(context);
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
                                      fontSize:
                                          SizeConfig.screenHeight! * 0.018,
                                    ),
                                  ),
                                  GradientText(
                                    text: S.of(context).create_account,
                                    route: () => Signup(),
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
        ),
      ),
    );
  }
}
