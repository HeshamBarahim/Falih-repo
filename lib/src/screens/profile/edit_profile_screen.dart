import 'dart:io';

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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../config/const.dart';
import '../../config/sizes.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

  final UserController userController = Get.put(UserController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int imageType = 0;

  File? file;

  String? ProfileImgUrl;

  String? fileExtension;

  String userId = FirebaseAuth.instance.currentUser!.uid;
  ImagePickerType(BuildContext context) {
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
                  setState(() {
                    imageType = 0;
                    saveImage();
                    Navigator.pop(context);
                  });
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
                  setState(() {
                    imageType = 1;
                    saveImage();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  saveImage() async {
    final XFile? ChangeProfileImage;

    imageType == 0
        ? ChangeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.gallery)
        : ChangeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.camera);
    if (ChangeProfileImage != null) {
      file = File(ChangeProfileImage!.path);
      fileExtension = path.extension(ChangeProfileImage.path);
    }
    setState(() {});

    if (file == null) {
      Get.snackbar("Error", "No image selected");
      return;
    }

    try {
      // Generate a unique filename using user ID and timestamp
      String userId = FirebaseAuth.instance.currentUser!.uid;

      String fileName = '${userId}${fileExtension}';

      // Reference to Firebase Storage
      // final storageRef2 = FirebaseStorage.instance.refFromURL();
      final storageRef = FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$fileName');

      // Upload the file
      await storageRef.putFile(file!);

      // Retrieve the download URL
      ProfileImgUrl = await storageRef.getDownloadURL();

      setState(() {});

      Get.snackbar("Success", "Image uploaded successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
    }
  }

  getProfileImage() async {
    try {
      ProfileImgUrl = await FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$userId.png')
          .getDownloadURL();
    } catch (e) {
      ProfileImgUrl = await FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$userId.jpg')
          .getDownloadURL();
    }
    setState(() {});
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

  @override
  void initState() {
    // TODO: implement initState
    getProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = userController.currentUser;
    if (user != null) {
      signUpController.fullName.text = user.fullName;
      signUpController.phoneNo.text = user.phoneNo;
      signUpController.schoolName.text = user.schoolName;
      signUpController.selectedGovernorate.value = user.selectedGovernorate;
      signUpController.selectedGrade.value = user.selectedGrade;
      signUpController.selectedGender.value = user.selectedGender;
    }
    SizeConfig().init(context);
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
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: SizeConfig.screenWidth! * 0.141,
                        backgroundImage: ProfileImgUrl != null
                            ? NetworkImage('$ProfileImgUrl')
                            : AssetImage(
                                Images.test,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: SizeConfig.screenWidth! * 0.08,
                          width: SizeConfig.screenWidth! * 0.08,
                          child: IconButton(
                            splashColor: Colors.black,
                            onPressed: () {
                              ImagePickerType(context);
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
                          myController: signUpController.fullName,
                          validator: Helper.validatefullName),
                      CustomTextForm(
                          hintText: S.of(context).hint_text_School,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          myController: signUpController.schoolName,
                          validator: Helper.validateSchoolName),
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
                            id: user?.id,
                            fullName: signUpController.fullName.text.trim(),
                            phoneNo: user?.phoneNo ?? '',
                            fakeEmail: user?.fakeEmail ?? '',
                            schoolName: signUpController.schoolName.text.trim(),
                            selectedGovernorate:
                                signUpController.selectedGovernorate.value,
                            selectedGrade: signUpController.selectedGrade.value,
                            selectedGender:
                                signUpController.selectedGender.value,
                            selectedDepartment: user?.selectedDepartment,
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
