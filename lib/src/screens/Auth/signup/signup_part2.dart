import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/next_button.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_rich_text.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPart2 extends StatelessWidget {
  SignupPart2({super.key});

  // Initialize the controller
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Form(
        // Container for background image
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
                      BlendMode.lighten))),
          padding: const EdgeInsets.all(20),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // logo of falih
                  Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      Images.logoFalih,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Create Account title & step 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).title_signup,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      Text(
                        S.of(context).step2_of_2,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // strat the fields of forms
                  // school fields
                  CustomTextForm(
                    hintText: S.of(context).hint_text_School,
                    prefixIcon: const Icon(Icons.location_city),
                  ),
                  // Grade dorp down
                  CustomDropDownForm(
                    hintText: S.of(context).hint_text_Grade,
                    prefixIcon: const Icon(Icons.location_pin),
                    list: [
                      DropdownMenuItem(
                          value: "one",
                          child: Text(S.of(context).drop_grade_val1)),
                      DropdownMenuItem(
                          value: 'Two',
                          child: Text(S.of(context).drop_grade_val2)),
                    ],
                  ),
                  // password field
                  CustomTextForm(
                    hintText: S.of(context).hint_text_confirm,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  // Confirm password field
                  CustomTextForm(
                    hintText: S.of(context).hint_text_confirm,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // the the rules text and check box
                  Obx(() => Row(
                        children: [
                          Checkbox(
                              value: signupController.isChecked.value,
                              onChanged: (bool? value) {
                                signupController.toggleCheckbox(value!);
                              }),
                          const CustomRichText(),
                        ],
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  // create acconunt button
                  GradientButton(
                      text: S.of(context).create_account,
                      height: 50,
                      width: double.infinity,
                      onClick: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  // last text below button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).bottom_text_part1,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GradientText(
                          text: S.of(context).bottom_text_part2,
                          route: '/login')
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
