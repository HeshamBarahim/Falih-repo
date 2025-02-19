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
          key: forgetPasswordController.forgetPasswordFormKey,
          child: Padding(
            // padding: const EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.screenHeight! * 0.02,
                horizontal: SizeConfig.screenWidth! * 0.04),
            child: SafeArea(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.,
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
                              S.of(context).search_for_account,
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
                            myController: forgetPasswordController.phoneNumber,
                            errorMessage:
                                forgetPasswordController.phoneNumberError.value
                                    ? forgetPasswordController
                                        .phoneNumberErrorMessage.value
                                    : null,
                            validator: Helper.validatePhoneNumber,
                            labelText: S.of(context).hint_text_phone,
                            prefixIcon: Icon(
                              Icons.account_circle,
                              size: SizeConfig.screenHeight! * 0.03,
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
                      onClick: () {
                        forgetPasswordController.checkPhoneNumber();
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.07),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
