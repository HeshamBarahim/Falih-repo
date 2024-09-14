import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_rich_text.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  // Initialize the controller
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    // list of
    List<Map<String, dynamic>> fields = [
      {
        'text': S.of(context).hint_text_phone,
        'icon': const Icon(Icons.phone_android)
      },
      {
        'text': S.of(context).hint_text_username,
        'icon': const Icon(Icons.person)
      },
      {
        'text': S.of(context).hint_text_Governorate,
        'icon': const Icon(Icons.add_home)
      },
      {
        'text': S.of(context).hint_text_School,
        'icon': const Icon(Icons.location_city)
      },
      {
        'text': S.of(context).hint_text_Grade,
        'icon': const Icon(Icons.location_pin)
      },
      {
        'text': S.of(context).hint_text_password,
        'icon': const Icon(Icons.lock)
      },
      {'text': S.of(context).hint_text_confirm, 'icon': const Icon(Icons.lock)},
    ];

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
                  // title of the signup
                  Container(
                    margin: const EdgeInsets.only(right: 130),
                    child: Text(S.of(context).title_signup,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                  // build the fields of signup
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: fields.length,
                      itemBuilder: (context, index) {
                        if (fields[index]['text'] ==
                            S.of(context).hint_text_Governorate) {
                          return CustomDropDownForm(
                            hintText: S.of(context).hint_text_Governorate,
                            prefixIcon: const Icon(Icons.location_pin),
                            list: [
                              DropdownMenuItem(
                                  value: "one",
                                  child: Text(
                                      S.of(context).drop_governorate_val1)),
                              DropdownMenuItem(
                                  value: 'Two',
                                  child: Text(
                                      S.of(context).drop_governorate_val2)),
                              DropdownMenuItem(
                                  value: 'Three',
                                  child: Text(
                                      S.of(context).drop_governorate_val3)),
                            ],
                          );
                        } else if (fields[index]['text'] ==
                            S.of(context).hint_text_Grade) {
                          return CustomDropDownForm(
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
                          );
                        } else {
                          return CustomTextForm(
                            hintText: fields[index]['text'],
                            prefixIcon: fields[index]['icon'],
                          );
                        }
                      }),
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
