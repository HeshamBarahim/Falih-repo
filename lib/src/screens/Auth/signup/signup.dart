import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/next_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';

import '../../../config/sizes.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  String error = '';
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Form(
          key: controller.signupFormKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: const AssetImage(Images.backgroundImageOfAuth),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                  BlendMode.lighten,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.05,
                vertical: SizeConfig.screenHeight! * 0.01),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Image.asset(
                              Images.logoFalih,
                              width: SizeConfig.screenWidth! * 0.5,
                              height: SizeConfig.screenHeight! * 0.16,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).title_signup,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenWidth! * 0.05,
                                ),
                              ),
                              Text(
                                S.of(context).step1_of_2,
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth! * 0.04),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenHeight! * 0.01),
                          CustomTextForm(
                            hintText: S.of(context).hint_text_phone,
                            prefixIcon: Icon(
                              Icons.phone_android,
                              size: SizeConfig.screenWidth! * 0.06,
                            ),
                            myController: controller.phoneNo,
                            validator: Helper.validatePhoneNumber,
                          ),
                          CustomTextForm(
                            hintText: S.of(context).hint_text_username,
                            prefixIcon: Icon(
                              Icons.person,
                              size: SizeConfig.screenWidth! * 0.06,
                            ),
                            myController: controller.fullName,
                            validator: Helper.validatefullName,
                          ),
                          CustomTextForm(
                            hintText: S.of(context).hint_text_School,
                            prefixIcon: Icon(
                              Icons.school,
                              size: SizeConfig.screenWidth! * 0.06,
                            ),
                            myController: controller.schoolName,
                            validator: Helper.validateSchoolName,
                          ),
                          CustomDropDownForm(
                            onChanged: (newValue) {
                              controller.selectedGovernorate.value = newValue;
                            },
                            selectedValue: controller.selectedGovernorate.value,
                            hintText: S.of(context).hint_text_Governorate,
                            prefixIcon: Icon(
                              Icons.location_pin,
                              size: SizeConfig.screenWidth! * 0.06,
                            ),
                            list: [
                              DropdownMenuItem(
                                value: "Sana'a",
                                child: Text(
                                  S.of(context).drop_governorate_val1,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Taiz',
                                child: Text(
                                  S.of(context).drop_governorate_val2,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Ibb',
                                child: Text(
                                  S.of(context).drop_governorate_val3,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                            ],
                          ),
                          CustomDropDownForm(
                            onChanged: (newValue) {
                              controller.selectedGrade.value = newValue;
                            },
                            selectedValue: controller.selectedGrade.value,
                            hintText: S.of(context).hint_text_Grade,
                            prefixIcon: Icon(
                              Icons.location_pin,
                              size: SizeConfig.screenWidth! * 0.06,
                            ),
                            list: [
                              DropdownMenuItem(
                                value: "9",
                                child: Text(
                                  S.of(context).drop_grade_val1,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                              DropdownMenuItem(
                                value: '12',
                                child: Text(
                                  S.of(context).drop_grade_val2,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                            ],
                          ),
                          CustomDropDownForm(
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
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Ar',
                                child: Text(
                                  S.of(context).drop_depatment_val2,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                            ],
                          ),
                          CustomDropDownForm(
                            onChanged: (newValue) {
                              controller.selectedGender.value = newValue;
                            },
                            selectedValue: controller.selectedGender.value,
                            hintText: S.of(context).male,
                            prefixIcon: Icon(
                              Icons.home_work_outlined,
                              size: SizeConfig.screenWidth! * 0.06,
                            ),
                            list: [
                              DropdownMenuItem(
                                value: "Male",
                                child: Text(S.of(context).male),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(
                                  S.of(context).female,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.035),
                                ),
                              ),
                            ],
                          ),
                          CustomTextForm(
                            hintText: S.of(context).hint_text_confirm,
                            prefixIcon: Icon(
                              Icons.lock,
                              size: SizeConfig.screenWidth! * 0.06,
                            ),
                            myController: controller.password,
                            validator: Helper.validatePassword,
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.03),
                      Column(
                        children: [
                          NextButton(
                            funtion: () {
                              controller.createUser(context);
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
                                ),
                              ),
                              GradientText(
                                text: S.of(context).bottom_text_part2,
                                route: () => Login(),
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
