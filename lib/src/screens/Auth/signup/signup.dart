import 'package:falih/generated/l10n.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/next_button.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  String error = '';
  // Initialize the controller
  final SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Form(
        key: controller.signupFormKey,
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
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        // logo of falih
                        Container(
                          color: Colors.transparent,
                          child: Image.asset(
                            Images.logoFalih,
                            width: 150.w,
                            height: 150.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Create Account title & step 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).title_signup,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                )),
                            Text(
                              S.of(context).step1_of_2,
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        // strat the fields of forms
                        // phone fields
                        CustomTextForm(
                            hintText: S.of(context).hint_text_phone,
                            prefixIcon: const Icon(Icons.phone_android),
                            myController: controller.phoneNo,
                            validator: Helper.validatePhoneNumber),
                        // fullname fields
                        CustomTextForm(
                            hintText: S.of(context).hint_text_username,
                            prefixIcon: const Icon(Icons.person),
                            myController: controller.fullName,
                            validator: Helper.validatefullName),
                        CustomTextForm(
                            hintText: 'school Name',
                            prefixIcon: const Icon(Icons.person),
                            myController: controller.schoolName,
                            validator: Helper.validateSchoolName),
                        // Governorate dorp down
                        Obx(() {
                          return CustomDropDownForm(
                            hintText: S.of(context).hint_text_Governorate,
                            prefixIcon: const Icon(Icons.location_pin),
                            list: [
                              DropdownMenuItem(
                                  value: "Sana'a",
                                  child: Text(
                                      S.of(context).drop_governorate_val1)),
                              DropdownMenuItem(
                                  value: 'Taiz',
                                  child: Text(
                                      S.of(context).drop_governorate_val2)),
                              DropdownMenuItem(
                                  value: 'Ibb',
                                  child: Text(
                                      S.of(context).drop_governorate_val3)),
                            ],
                            onChanged: (newValue) {
                              controller.selectedGovernorate.value = newValue;
                            },
                            selectedValue: controller.selectedGovernorate.value,
                          );
                        }),
                        // Grade dorp down
                        CustomDropDownForm(
                          onChanged: (newValue) {
                            controller.selectedGrade.value = newValue;
                          },
                          selectedValue: controller.selectedGrade.value,
                          hintText: S.of(context).hint_text_Grade,
                          prefixIcon: const Icon(Icons.location_pin),
                          list: [
                            DropdownMenuItem(
                                value: "9",
                                child: Text(S.of(context).drop_grade_val1)),
                            DropdownMenuItem(
                                value: '12',
                                child: Text(S.of(context).drop_grade_val2)),
                          ],
                        ),
                        // Department dorp down
                        CustomDropDownForm(
                          onChanged: (newValue) {
                            controller.selectedDepartment.value = newValue;
                          },
                          selectedValue: controller.selectedGrade.value,
                          hintText: S.of(context).hint_text_department,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          list: [
                            DropdownMenuItem(
                                value: "En",
                                child: Text(S.of(context).drop_depatment_val1)),
                            DropdownMenuItem(
                                value: 'Ar',
                                child: Text(S.of(context).drop_depatment_val2)),
                          ],
                        ),
                        // password field
                        CustomTextForm(
                          hintText: S.of(context).hint_text_confirm,
                          prefixIcon: const Icon(Icons.lock),
                          myController: controller.password,
                          validator: Helper.validatePassword,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * .05),
                    Column(
                      children: [
                        // next button
                        NextButton(funtion: () {
                          controller.createUser();
                          // Get.to(() => Login());
                          // await FirebaseAuth.instance.verifyPhoneNumber(
                          //   phoneNumber: '+1 1234567890',
                          //   verificationCompleted:
                          //       (PhoneAuthCredential credential) {},
                          //   verificationFailed: (FirebaseAuthException e) {
                          //     error = e.code;
                          //   },
                          //   codeSent: (String verificationId, int? resendToken) {
                          //     Get.to(() => Otp(), arguments: {
                          //       "verificationId": verificationId,
                          //     });
                          //   },
                          //   codeAutoRetrievalTimeout: (String verificationId) {},
                          // );
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                        // last text below button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).bottom_text_part1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.sp),
                            ),
                            GradientText(
                                text: S.of(context).bottom_text_part2,
                                route: '/login')
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
