import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_agreeing_check.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_check_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/sizes.dart';
import '../widgets_auth/text_form_field.dart';

class SignupPart2 extends StatelessWidget {
  SignupPart2({super.key});

  final SignUpController controller =
      Get.put(SignUpController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Form(
        key: controller.signupFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.falih,
                  width: SizeConfig.screenWidth! * 0.4,
                  height: SizeConfig.screenWidth! * 0.4,
                  fit: BoxFit.contain,
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
                        S.of(context).step2_of_2,
                        style: const TextStyle(
                            color: AppColors.darkMainColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.015),
                CustomTextForm(
                  keyFormatter: false,
                  keyboardType: TextInputType.text,
                  myController: controller.schoolName,
                  validator: Helper.validateSchoolName,
                  labelText: S.of(context).hint_text_School,
                  prefixIcon: Icon(
                    Icons.school,
                    size: SizeConfig.screenWidth! * 0.06,
                  ),
                ),
                CustomDropDownForm(
                  validator: Helper.validateDepartment,
                  onChanged: (newValue) {
                    controller.selectedDepartment.value = newValue;
                  },
                  selectedValue: controller.selectedDepartment.value,
                  hintText: S.of(context).hint_text_department,
                  prefixIcon: Icon(
                    Icons.home_work_outlined,
                    size: SizeConfig.screenWidth! * 0.06,
                  ),
                  list: [
                    DropdownMenuItem(
                      value: "En",
                      child: Text(
                        S.of(context).drop_depatment_val1,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Ar',
                      child: Text(
                        S.of(context).drop_depatment_val2,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomDropDownForm(
                  validator: Helper.validateGovernorate,
                  onChanged: (newValue) {
                    controller.selectedGovernorate.value = newValue;
                  },
                  selectedValue: controller.selectedGovernorate.value,
                  hintText: S.of(context).hint_text_Governorate,
                  prefixIcon: Icon(
                    Icons.location_city,
                    size: SizeConfig.screenWidth! * 0.06,
                  ),
                  list: [
                    DropdownMenuItem(
                      value: "Sana'a",
                      child: Text(
                        S.of(context).drop_governorate_val1,
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: SizeConfig.screenWidth! * 0.035),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Taiz',
                      child: Text(
                        S.of(context).drop_governorate_val2,
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: SizeConfig.screenWidth! * 0.035),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Ibb',
                      child: Text(
                        S.of(context).drop_governorate_val3,
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: SizeConfig.screenWidth! * 0.035),
                      ),
                    ),
                  ],
                ),
                CustomDropDownForm(
                  validator: Helper.validateGrade,
                  onChanged: (newValue) {
                    controller.selectedGrade.value = newValue;
                  },
                  selectedValue: controller.selectedGrade.value,
                  hintText: S.of(context).hint_text_Grade,
                  prefixIcon: Icon(
                    Icons.book_rounded,
                    size: SizeConfig.screenWidth! * 0.06,
                  ),
                  list: [
                    DropdownMenuItem(
                      value: "9",
                      child: Text(
                        S.of(context).drop_grade_val1,
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: SizeConfig.screenWidth! * 0.035),
                      ),
                    ),
                    DropdownMenuItem(
                      value: '12',
                      child: Text(
                        S.of(context).drop_grade_val2,
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: SizeConfig.screenWidth! * 0.035),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.03),
                CustomAgreeingCheck(
                  onChange: (value) => controller.toggleCheckbox(value!),
                  value: controller.isChecked,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.05),
                Obx(
                  () => CustomCheckButton(
                    isChecked: controller.isChecked.value,
                    text: S.of(context).title_signup,
                    height: SizeConfig.screenHeight! * 0.06,
                    width: double.infinity,
                    onClick: () {
                      controller.createUser(context);
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.03),
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
                      text: S.of(context).login,
                      route: () => Get.back(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
