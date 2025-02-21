import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../config/images.dart';
import '../../../config/sizes.dart';
import '../../../config/themes.dart';
import '../../../controller/forget_password_controller.dart';
import '../../../helper/helper_controller.dart';
import '../widgets_auth/gradient_button.dart';
import '../widgets_auth/text_form_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Form(
            key: forgetPasswordController.forgetPasswordFormKey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.02,
                  horizontal: constraints.maxWidth * 0.04,
                ),
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
                                  vertical: constraints.maxHeight * 0.02),
                              child: Text(
                                S.of(context).search_for_account,
                                style: TextStyle(
                                  color: AppColors.darkMainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxWidth *
                                      0.07, // Responsive font size
                                ),
                              ),
                            ),
                            CustomTextForm(
                              keyFormatter: true,
                              keyboardType: TextInputType.text,
                              myController:
                                  forgetPasswordController.phoneNumber,
                              errorMessage: forgetPasswordController
                                      .phoneNumberError.value
                                  ? forgetPasswordController
                                      .phoneNumberErrorMessage.value
                                  : null,
                              validator: Helper.validatePhoneNumber,
                              labelText: S.of(context).hint_text_phone,
                              prefixIcon: Icon(
                                Icons.account_circle,
                                size: constraints.maxHeight * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    // Adds spacing before button
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.1),
                      child: FractionallySizedBox(
                        widthFactor: 0.9, // Ensures button scales properly
                        child: GradientButton(
                          text: S.of(context).continueText,
                          height: constraints.maxHeight * 0.06,
                          onClick: () =>
                              forgetPasswordController.checkPhoneNumber(),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    // Prevents overflow
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
