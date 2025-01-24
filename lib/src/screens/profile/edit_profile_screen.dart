import 'package:cached_network_image/cached_network_image.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/profile_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/sizes.dart';
import '../../config/themes.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Navigate to the menu screen when the user tries to pop
          Get.back();
        }
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                Images.backgroundImageOfAuth,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                  BlendMode.lighten),
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: profileController.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * .10),
                    GetBuilder<ProfileController>(
                      init: ProfileController(),
                      builder: (controller) => Stack(
                        children: [
                          CircleAvatar(
                            radius: SizeConfig.screenWidth! * 0.141,
                            backgroundColor: Colors.grey[200],
                            child: ClipOval(
                              child: controller.isProfileImgLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth:
                                            SizeConfig.screenWidth! * 0.008,
                                        strokeAlign:
                                            SizeConfig.screenWidth! * 0.003,
                                      ),
                                    )
                                  : controller.userProfileImgUrl.value != ''
                                      ? CachedNetworkImage(
                                          key: ValueKey(
                                              controller.userProfileImgUrl),
                                          imageUrl: controller
                                              .userProfileImgUrl.value!,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          width:
                                              SizeConfig.screenWidth! * 0.282,
                                          height:
                                              SizeConfig.screenWidth! * 0.282,
                                        )
                                      : Image.asset(
                                          Images.test,
                                          fit: BoxFit.cover,
                                          width:
                                              SizeConfig.screenWidth! * 0.282,
                                          height:
                                              SizeConfig.screenWidth! * 0.282,
                                        ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                              height: SizeConfig.screenWidth! * 0.08,
                              width: SizeConfig.screenWidth! * 0.08,
                              child: IconButton(
                                splashColor: Colors.black,
                                onPressed: () {
                                  controller.imagePickerDialog(context);
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.mainColor,
                                ),
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: SizeConfig.screenWidth! * 0.044,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * .10),
                    Column(
                      children: [
                        CustomTextForm(
                            hintText: S.of(context).hint_text_username,
                            prefixIcon: const Icon(Icons.person),
                            myController: profileController.fullName,
                            validator: Helper.validatefullName),
                        CustomTextForm(
                            hintText: S.of(context).hint_text_School,
                            prefixIcon: const Icon(Icons.home_work_outlined),
                            myController: profileController.schoolName,
                            validator: Helper.validateSchoolName),
                        CustomDropDownForm(
                          validator: Helper.validateGovernorate,
                          onChanged: (newValue) {
                            profileController.selectedGovernorate.value =
                                newValue;
                          },
                          selectedValue:
                              profileController.selectedGovernorate.value,
                          hintText: S.of(context).hint_text_Governorate,
                          prefixIcon: const Icon(Icons.location_pin),
                          list: [
                            DropdownMenuItem(
                                value: "Sana'a",
                                child:
                                    Text(S.of(context).drop_governorate_val1)),
                            DropdownMenuItem(
                                value: 'Taiz',
                                child:
                                    Text(S.of(context).drop_governorate_val2)),
                            DropdownMenuItem(
                                value: 'Ibb',
                                child:
                                    Text(S.of(context).drop_governorate_val3)),
                          ],
                        ),
                        // CustomDropDownForm(
                        //   validator: Helper.validateGrade,
                        //   hintText: 'hintText',
                        //   prefixIcon: Icon(Icons.abc),
                        //   list: [],
                        //   onChanged: (val) {},
                        // ),
                        CustomDropDownForm(
                          validator: Helper.validateGrade,
                          onChanged: (newValue) {
                            profileController.selectedGrade.value = newValue;
                          },
                          selectedValue: profileController.selectedGrade.value,
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
                        CustomDropDownForm(
                          validator: Helper.validateGrade,
                          onChanged: (newValue) {
                            profileController.selectedGender.value = newValue;
                          },
                          selectedValue: profileController.selectedGender.value,
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
                    Obx(
                      () => profileController.isSavingData.value == false
                          ? GradientButton(
                              text: S.of(context).update_profile,
                              height: 50,
                              width: double.infinity,
                              onClick: () async {
                                if (profileController.formKey.currentState!
                                    .validate()) {
                                  profileController.updateUserData();
                                }
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
