import 'package:falih/src/config/themes.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/signup/singup.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_agreeing_check.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_check_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import '../../../config/sizes.dart';
import '../../../controller/show_password_controller.dart';
import '../widgets_auth/password_text_form_field.dart';

class SignupPart2 extends StatelessWidget {
  SignupPart2({super.key});

  final SignUpController controller =
      Get.put(SignUpController(), permanent: false);

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
              vertical: SizeConfig.screenHeight! * 0.02,
            ),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: SizeConfig.screenWidth! * 0.100,
                    color: AppColors.mainColor,
                  ),
                  onPressed: () {
                    controller.goToPreviousPage();
                  },
                ),
              ),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight! * 0.05),
                    Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        Images.falih,
                        width: SizeConfig.screenWidth! * 0.5,
                        height: SizeConfig.screenHeight! * 0.2,
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
                            fontSize: SizeConfig.screenWidth! * 0.06,
                          ),
                        ),
                        Text(
                          S.of(context).step2_of_2,
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth! * 0.04),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.015),
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
                            style: TextStyle(
                                fontSize: SizeConfig.screenWidth! * 0.035),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Ar',
                          child: Text(
                            S.of(context).drop_depatment_val2,
                            style: TextStyle(
                                fontSize: SizeConfig.screenWidth! * 0.035),
                          ),
                        ),
                      ],
                    ),
                    CustomDropDownForm(
                      validator: Helper.validateGender,
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
                                fontSize: SizeConfig.screenWidth! * 0.035),
                          ),
                        ),
                      ],
                    ),
                    GetBuilder<ShowPasswordController>(
                      init: ShowPasswordController(),
                      builder: (showPasswordController) =>
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
                    ),
                    GetBuilder<ShowPasswordController>(
                      init: ShowPasswordController(),
                      builder: (showPasswordController) =>
                          CustomPasswordTextForm(
                        myController: controller.rePassword,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return S.current.passwrod_cant_be_empty;
                          } else if (val != controller.password.text.trim()) {
                            return S.current.passwords_doesnt_match;
                          }
                          return null;
                        },
                        labelText: S.of(context).hint_text_confirm,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: SizeConfig.screenHeight! * 0.03,
                        ),
                        obscureText: showPasswordController.obText2,
                        showPasswordFunction:
                            showPasswordController.showPasswordFunction_2,
                      ),
                    ),
                    // CustomTextForm(
                    //   keyFormatter: true,
                    //   keyboardType: TextInputType.visiblePassword,
                    //   myController: controller.password,
                    //   validator: Helper.validatePassword,
                    //   prefixIcon: Icon(
                    //     Icons.lock,
                    //     size: SizeConfig.screenWidth! * 0.06,
                    //   ),
                    // ),
                    // CustomTextForm(
                    //   keyFormatter: true,
                    //   keyboardType: TextInputType.visiblePassword,
                    //   myController: controller.rePassword,
                    //   validator:
                    //   labelText: S.of(context).hint_text_confirm,
                    //   prefixIcon: Icon(
                    //     Icons.lock,
                    //     size: SizeConfig.screenWidth! * 0.06,
                    //   ),
                    // ),
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
                          ),
                        ),
                        GradientText(
                          text: S.of(context).bottom_text_part2,
                          route: () => Signup(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
