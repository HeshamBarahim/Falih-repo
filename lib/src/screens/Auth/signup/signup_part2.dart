import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_rich_text.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';

import '../../../config/sizes.dart';

class SignupPart2 extends StatelessWidget {
  SignupPart2({super.key});

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
              vertical: SizeConfig.screenHeight! * 0.02,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight! * 0.05),
                    Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        Images.logoFalih,
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
                      onChanged: (newValue) {
                        controller.selectedGovernorate.value = newValue;
                      },
                      selectedValue: controller.selectedGovernorate.value,
                      hintText: S.of(context).hint_text_Grade,
                      prefixIcon: Icon(
                        Icons.location_pin,
                        size: SizeConfig.screenHeight! * 0.03,
                      ),
                      list: [
                        DropdownMenuItem(
                          value: "one",
                          child: Text(S.of(context).drop_grade_val1),
                        ),
                        DropdownMenuItem(
                          value: 'Two',
                          child: Text(S.of(context).drop_grade_val2),
                        ),
                      ],
                    ),
                    CustomTextForm(
                      hintText: S.of(context).hint_text_confirm,
                      prefixIcon: Icon(
                        Icons.lock,
                        size: SizeConfig.screenHeight! * 0.03,
                      ),
                      myController: controller.password,
                      validator: (value) {
                        if (value!.isEmpty) return 'password cannot be empty';
                        return null;
                      },
                    ),
                    CustomTextForm(
                      hintText: S.of(context).hint_text_confirm,
                      prefixIcon: Icon(
                        Icons.lock,
                        size: SizeConfig.screenHeight! * 0.03,
                      ),
                      myController: controller.password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'confirm password cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.015),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: controller.isChecked.value,
                              onChanged: (bool? value) {
                                controller.toggleCheckbox(value!);
                              },
                            ),
                            const CustomRichText(),
                          ],
                        )),
                    SizedBox(height: SizeConfig.screenHeight! * 0.05),
                    GradientButton(
                      text: S.of(context).create_account,
                      height: SizeConfig.screenHeight! * 0.06,
                      width: double.infinity,
                      onClick: () {},
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
                          route: '/login',
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
