import 'package:cached_network_image/cached_network_image.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/controller/profile_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/screens/Auth/widgets_auth/drop_down_form.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/const.dart';
import '../../config/sizes.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final UserController userController = Get.put(UserController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage(
                  Images.backgroundImageOfAuth,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                    BlendMode.lighten))),
        child: Form(
            key: profileController.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * .10),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: SizeConfig.screenWidth! * 0.141,
                        backgroundColor: Colors.grey[200],
                        child: Obx(
                          () => ClipOval(
                            child: profileController.profileImgUrl.value != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        profileController.profileImgUrl.value!,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: SizeConfig.screenWidth! * 0.282,
                                    height: SizeConfig.screenWidth! * 0.282,
                                  )
                                : Image.asset(
                                    Images.test,
                                    fit: BoxFit.cover,
                                    width: SizeConfig.screenWidth! * 0.282,
                                    height: SizeConfig.screenWidth! * 0.282,
                                  ),
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
                              imagePickerDialog(context);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: iconColor_2,
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
                              child: Text(S.of(context).drop_governorate_val1)),
                          DropdownMenuItem(
                              value: 'Taiz',
                              child: Text(S.of(context).drop_governorate_val2)),
                          DropdownMenuItem(
                              value: 'Ibb',
                              child: Text(S.of(context).drop_governorate_val3)),
                        ],
                      ),
                      CustomDropDownForm(
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
                  Obx(() => profileController.isSavingData.value == false
                      ? GradientButton(
                          text: S.of(context).update_profile,
                          height: 50.h,
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
                        ))
                ],
              ),
            )),
      ),
    );
  }

  void imagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.image,
                  size: 25.0,
                ),
                title: const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  // setState(() {
                  //   imageType = 0;
                  //   saveImage();
                  //   userController.setProfileImageUrl(ProfileImgUrl!);
                  //   Navigator.pop(context);
                  // });
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  size: 25.0,
                ),
                title: const Text(
                  'Take Photo',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  // setState(() {
                  //   imageType = 1;
                  //   saveImage();
                  //   Navigator.pop(context);
                  // });
                },
              ),
            ],
          ),
        );
      },
    );
  }

// loadingDialog() {
//   Future<void> _performLongRunningTask(BuildContext context) async {
//     // Show loading dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent dismissing by tapping outside
//       builder: (BuildContext context) {
//         return const Dialog(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(width: 16.0),
//                 Text("Loading..."),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   // await Future.delayed(const Duration(seconds: 5));

//   // Navigator.of(context).pop();
// }
}
