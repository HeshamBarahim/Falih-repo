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
                              backgroundColor: AppColors.darkMainColor,
                              child: CircleAvatar(
                                radius: (SizeConfig.screenWidth! * 0.141),
                                backgroundColor: AppColors.mainColor,
                                backgroundImage: c2.file2 != null
                                    ? FileImage(c2.file2!)
                                    : AssetImage(
                                        'assets/images/person.jpg',
                                        // fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                height: SizeConfig.screenWidth! * 0.08,
                                width: SizeConfig.screenWidth! * 0.08,
                                child: IconButton(
                                  splashColor: Colors.black,
                                  onPressed: () {
                                    c2.imagePickerDialog(context);
                                  },
                                  style: IconButton.styleFrom(
                                      // backgroundColor:
                                      //     controller.userProfileImgUrl.value == ""
                                      //         ? AppColors.lightenMainColor
                                      //         : AppColors.mainColor,
                                      ),
                                  icon: Icon(
                                    Icons.edit,
                                    // color:
                                    //     controller.userProfileImgUrl.value == ""
                                    //         ? AppColors.mainColor
                                    //         : Colors.white,
                                    size: SizeConfig.screenWidth! * 0.044,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).title_signup,
                              style: const TextStyle(
                                color: AppColors.darkMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              S.of(context).step1_of_2,
                              style: const TextStyle(
                                  color: AppColors.darkMainColor, fontSize: 18),
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
                        prefixIcon: Icon(
                          Icons.phone_android,
                          size: SizeConfig.screenWidth! * 0.06,
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
                          size: SizeConfig.screenWidth! * 0.06,
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
                        prefixIcon: Icon(
                          Icons.account_circle,
                          size: SizeConfig.screenWidth! * 0.06,
                        ),
                      ),
                      CustomDropDownForm(
                        validator: Helper.validateGender,
                        onChanged: (newValue) {
                          controller.selectedGender.value = newValue;
                        },
                        selectedValue: controller.selectedGender.value,
                        hintText: S.of(context).male,
                        prefixIcon: Icon(
                          Icons.person_outline,
                          size: SizeConfig.screenWidth! * 0.06,
                        ),
                        list: [
                          DropdownMenuItem(
                            value: "Male",
                            child: Text(
                              S.of(context).male,
                              style: const TextStyle(
                                  color: AppColors.mainColor, fontSize: 16),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text(
                              S.of(context).female,
                              style: const TextStyle(
                                  color: AppColors.mainColor, fontSize: 16),
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
                              prefixIcon: Icon(
                                Icons.lock,
                                size: SizeConfig.screenHeight! * 0.03,
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
                              prefixIcon: Icon(
                                Icons.lock,
                                size: SizeConfig.screenHeight! * 0.03,
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
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenWidth! * 0.035,
                              color: AppColors.darkMainColor,
                            ),
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
