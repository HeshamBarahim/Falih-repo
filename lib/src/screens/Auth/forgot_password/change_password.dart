import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../config/images.dart';
import '../../../config/sizes.dart';
import '../../../config/themes.dart';
import '../../../controller/change_password_controller.dart';
import '../../../controller/show_password_controller.dart';
import '../../../helper/helper_controller.dart';
import '../widgets_auth/gradient_button.dart';
import '../widgets_auth/password_text_form_field.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Form(
        key: changePasswordController.changePasswordFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight! * 0.02,
              horizontal: SizeConfig.screenWidth! * 0.04),
          child: SafeArea(
            child: Column(
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
                            S.of(context).change_password_text,
                            style: const TextStyle(
                              color: AppColors.darkMainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        GetBuilder<ShowPasswordController>(
                          init: ShowPasswordController(),
                          builder: (showPasswordController) => Column(
                            children: [
                              CustomPasswordTextForm(
                                myController: changePasswordController.password,
                                validator: Helper.validatePassword,
                                labelText: S.of(context).hint_text_new_password,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: SizeConfig.screenHeight! * 0.03,
                                ),
                                obscureText: showPasswordController.obText,
                                showPasswordFunction:
                                    showPasswordController.showPasswordFunction,
                              ),
                              CustomPasswordTextForm(
                                myController:
                                    changePasswordController.rePassword,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return S.current.passwrod_cant_be_empty;
                                  } else if (val !=
                                      changePasswordController.password.text
                                          .trim()) {
                                    return S.current.passwords_doesnt_match;
                                  }
                                  return null;
                                },
                                labelText: S
                                    .of(context)
                                    .hint_text_new_password_confirm,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: SizeConfig.screenHeight! * 0.03,
                                ),
                                obscureText: showPasswordController.obText2,
                                showPasswordFunction: showPasswordController
                                    .showPasswordFunction_2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.1),
                  child: GradientButton(
                    text: S.of(context).continueText,
                    height: SizeConfig.screenHeight! * 0.06,
                    width: double.infinity,
                    onClick: () async {
                      // loginController.login(Get.context!);
                      changePasswordController.changePasswordFunction();
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.07),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
