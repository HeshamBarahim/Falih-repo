import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_rich_text.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isChecked = false;

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
                  Container(
                    child: Image.asset(
                      Images.logoFalih,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 130),
                    child: Text(S.of(context).title_signup,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                  // Text Fields
                  CustomTextForm(
                    hintText: S.of(context).hint_text_phone,
                    prefixIcon: const Icon(Icons.phone_android),
                  ),
                  CustomTextForm(
                    hintText: S.of(context).hint_text_username,
                    prefixIcon: const Icon(Icons.person),
                  ),
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
                  CustomTextForm(
                    hintText: S.of(context).hint_text_School,
                    prefixIcon: const Icon(Icons.location_city),
                  ),
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
                  CustomTextForm(
                    hintText: S.of(context).hint_text_password,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  CustomTextForm(
                    hintText: S.of(context).hint_text_confirm,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          }),
                      const CustomRichText(),
                    ],
                  ),
                  MaterialButton(
                    color: Colors.white,
                    height: 50,
                    minWidth: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    textColor: Colors.black,
                    onPressed: () {},
                    child: Text(
                      S.of(context).title_signup,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.shadowColor),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).bottom_text_part1,
                        style: const TextStyle(
                            // fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      GradientText(
                          text: S.of(context).bottom_text_part2, route: 'login')
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
