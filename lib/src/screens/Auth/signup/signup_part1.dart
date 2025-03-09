import 'package:falih/generated/l10n.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/screens/Auth/widgets_auth/next_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';
import '../../../config/themes.dart';
import '../../../controller/show_password_controller.dart';
import '../widgets_auth/password_text_form_field.dart';

class SignupPart1 extends StatelessWidget {
  SignupPart1({super.key});

  final String error = '';
  final SignUpController controller =
      Get.put(SignUpController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => SingleChildScrollView(
        child: Form(
          key: controller.signupFormKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GetBuilder<SignUpController>(
                          init: SignUpController(),
                          builder: (c2) => Stack(
                                children: [
                                  CircleAvatar(
                                    radius: SizeConfig.screenWidth! * 0.13,
                                    backgroundColor: AppColors.lightenMainColor,
                                    child: c2.file2 != null
                                        ? ClipOval(
                                            child: Image.file(
                                              c2.file2!,
                                              fit: BoxFit.cover,
                                              // Ensure the image covers the entire circle
                                              width: SizeConfig.screenWidth! *
                                                  0.26,
                                              // Match the diameter of the CircleAvatar
                                              height: SizeConfig.screenWidth! *
                                                  0.26,
                                            ),
                                          )
                                        : Icon(
                                            Icons.person,
                                            size:
                                                SizeConfig.screenWidth! * 0.15,
                                          ),
                                  ),
                                  Positioned(
                                    bottom: SizeConfig.screenWidth! * 0.01,
                                    // Adjust this value as needed
                                    right: SizeConfig.screenWidth! * 0.01,
                                    // Adjust this value as needed
                                    child: Container(
                                      height: SizeConfig.screenWidth! * 0.07,
                                      width: SizeConfig.screenWidth! * 0.07,
                                      decoration: const BoxDecoration(
                                        color: AppColors.mainColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        splashColor: Colors.transparent,
                                        // Remove splash effect
                                        onPressed: () {
                                          c2.imagePickerDialog(context);
                                        },
                                        padding: EdgeInsets.zero,
                                        // Remove default padding
                                        icon: Icon(
                                          Icons.edit,
                                          size: SizeConfig.screenWidth! * 0.044,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).title_signup,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              S.of(context).step1_of_2,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.01),
                      CustomTextForm(
                        keyFormatter: true,
                        keyboardType: TextInputType.number,
                        myController: controller.phoneNo,
                        validator: Helper.validatePhoneNumber,
                        labelText: S.of(context).hint_text_phone,
                        prefixIcon: const Icon(
                          Icons.phone_android,
                        ),
                      ),
                      CustomTextForm(
                        keyFormatter: false,
                        keyboardType: TextInputType.text,
                        myController: controller.fullName,
                        validator: Helper.validatefullName,
                        labelText: S.of(context).hint_text_fullname,
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                      ),
                      CustomTextForm(
                        keyFormatter: false,
                        keyboardType: TextInputType.text,
                        myController: controller.userName,
                        errorMessage: controller.userNameError.value
                            ? controller.userNameErrorMessage.value
                            : null,
                        // onChanged: Helper.onChangedUsername,
                        validator: Helper.validateUsername,
                        labelText: S.of(context).hint_text_username,
                        prefixIcon: const Icon(
                          Icons.account_box_rounded,
                        ),
                      ),
                      CustomDropDownForm(
                        validator: Helper.validateGender,
                        onChanged: (newValue) {
                          controller.selectedGender.value = newValue;
                        },
                        selectedValue: controller.selectedGender.value,
                        hintText: S.of(context).male,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                        ),
                        list: [
                          DropdownMenuItem(
                            value: "Male",
                            child: Text(
                              S.of(context).male,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text(
                              S.of(context).female,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      GetBuilder<ShowPasswordController>(
                        init: ShowPasswordController(),
                        builder: (showPasswordController) => Column(
                          children: [
                            CustomPasswordTextForm(
                              myController: controller.password,
                              validator: Helper.validatePassword,
                              labelText: S.of(context).hint_text_password,
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              obscureText: showPasswordController.obText,
                              showPasswordFunction:
                                  showPasswordController.showPasswordFunction,
                            ),
                            CustomPasswordTextForm(
                              myController: controller.rePassword,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return S.current.passwrod_cant_be_empty;
                                } else if (val !=
                                    controller.password.text.trim()) {
                                  return S.current.passwords_doesnt_match;
                                }
                                return null;
                              },
                              labelText:
                                  S.of(context).hint_text_password_confirm,
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              obscureText: showPasswordController.obText2,
                              showPasswordFunction:
                                  showPasswordController.showPasswordFunction_2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.03),
                  Column(
                    children: [
                      NextButton(
                        funtion: () {
                          if (controller.signupFormKey.currentState!
                              .validate()) {
                            controller.showUserNameErrorMessage();
                          }
                        },
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).bottom_text_part1,
                          ),
                          GradientText(
                            text: S.of(context).bottom_text_part2,
                            route: () => Get.back(),
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
    );
  }
}
