import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/next_button.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_rich_text.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

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
                  // Create Account title & step 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).title_signup,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      Text(
                        S.of(context).step1_of_2,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // strat the fields of forms
                  // phone fields
                  CustomTextForm(
                    hintText: S.of(context).hint_text_phone,
                    prefixIcon: const Icon(Icons.phone_android),
                  ),
                  // fullname fields
                  CustomTextForm(
                    hintText: S.of(context).hint_text_username,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  // Governorate dorp down
                  CustomDropDownForm(
                    hintText: S.of(context).hint_text_Governorate,
                    prefixIcon: const Icon(Icons.location_pin),
                    list: [
                      DropdownMenuItem(
                          value: "one",
                          child: Text(S.of(context).drop_governorate_val1)),
                      DropdownMenuItem(
                          value: 'Two',
                          child: Text(S.of(context).drop_governorate_val2)),
                      DropdownMenuItem(
                          value: 'Three',
                          child: Text(S.of(context).drop_governorate_val3)),
                    ],
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  // next button
                  const NextButton(
                    route: '/signupPart2',
                  ),
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
