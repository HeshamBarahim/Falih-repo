import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/signup_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/main_screen/menu_screen.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final SignUpController signUpController = Get.put(SignUpController());
  final UserController userController = Get.put(UserController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Initial values
    final user = userController.currentUser;
    if (user != null) {
      signUpController.fullName.text = user.fullName;
      signUpController.phoneNo.text = user.phoneNo;
      signUpController.schoolName.text = user.schoolName;
      signUpController.selectedGovernorate.value = user.selectedGovernorate;
      signUpController.selectedGrade.value = user.selectedGrade;
      signUpController.selectedGender.value = user.selectedGender;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
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
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * .10),
                  Container(
                    child: const CircleAvatar(
                      radius: 50, // Size of the circle
                      backgroundImage: AssetImage(Images.test),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * .10),
                  Column(
                    children: [
                      // Full Name fields
                      CustomTextForm(
                          hintText: S.of(context).hint_text_username,
                          prefixIcon: const Icon(Icons.person),
                          myController: signUpController.fullName,
                          validator: Helper.validatefullName),
                      // School Name fields
                      CustomTextForm(
                          hintText: S.of(context).hint_text_School,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          myController: signUpController.schoolName,
                          validator: Helper.validateSchoolName),
                      // Governorate dorp down
                      CustomDropDownForm(
                        onChanged: (newValue) {
                          signUpController.selectedGovernorate.value = newValue;
                        },
                        selectedValue:
                            signUpController.selectedGovernorate.value,
                        hintText: S.of(context).hint_text_Governorate,
                        prefixIcon: const Icon(Icons.location_pin),
                        list: [
                          DropdownMenuItem(
                              value: "Sana'a",
                              child: Text(S.of(context).drop_governorate_val1)),
                          DropdownMenuItem(
                              value: 'Taiz',
                              child: Text(S.of(context).drop_governorate_val2)),
                          DropdownMenuItem(
                              value: 'Ibb',
                              child: Text(S.of(context).drop_governorate_val3)),
                        ],
                      ),
                      // Grade dorp down
                      CustomDropDownForm(
                        onChanged: (newValue) {
                          signUpController.selectedGrade.value = newValue;
                        },
                        selectedValue: signUpController.selectedGrade.value,
                        hintText: S.of(context).hint_text_Grade,
                        prefixIcon: const Icon(Icons.school),
                        list: [
                          DropdownMenuItem(
                              value: "9",
                              child: Text(S.of(context).drop_grade_val1)),
                          DropdownMenuItem(
                              value: '12',
                              child: Text(S.of(context).drop_grade_val2)),
                        ],
                      ),
                      // Male & Female
                      CustomDropDownForm(
                        onChanged: (newValue) {
                          signUpController.selectedGender.value = newValue;
                        },
                        selectedValue: signUpController.selectedGender.value,
                        hintText: S.of(context).male,
                        prefixIcon: const Icon(Icons.person_pin_rounded),
                        list: [
                          DropdownMenuItem(
                              value: "Male", child: Text(S.of(context).male)),
                          DropdownMenuItem(
                              value: 'Female',
                              child: Text(S.of(context).female)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * .10),
                  GradientButton(
                    text: S.of(context).update_profile,
                    height: 50.h,
                    width: double.infinity,
                    onClick: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final updatedUser = UserModel(
                            id: user?.id, // Keep the same user ID
                            fullName: signUpController.fullName.text.trim(),
                            phoneNo:
                                user?.phoneNo ?? '', // Retain original phoneNo
                            fakeEmail: user?.fakeEmail ??
                                '', // Retain original fakeEmail
                            schoolName: signUpController.schoolName.text.trim(),
                            selectedGovernorate:
                                signUpController.selectedGovernorate.value,
                            selectedGrade: signUpController.selectedGrade.value,
                            selectedGender:
                                signUpController.selectedGender.value,
                            selectedDepartment: user
                                ?.selectedDepartment, // Retain original department
                          );

                          await userController.updateUser(updatedUser);
                          Helper.successSnackBar(
                            title: "Success",
                            message: "Profile updated successfully!",
                          );
                          Get.offAll(() => const MenuScreen());
                        } catch (e) {
                          Helper.errorSnackBar(
                            title: "Update Failed",
                            message: e.toString().isNotEmpty
                                ? e.toString()
                                : "An unexpected error occurred. Please try again.",
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * .10),
                ],
              ),
            )),
      ),
    );
  }
}
