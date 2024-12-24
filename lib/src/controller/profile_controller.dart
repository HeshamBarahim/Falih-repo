import 'dart:io';

import 'package:falih/src/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../helper/helper_controller.dart';
import '../models/user_model.dart';
import '../screens/main_screen/menu_screen.dart';
import 'loading_dialog_controller.dart';

class ProfileController extends GetxController {
  final UserController userController = Get.put(UserController());
  final showPassword = false.obs;
  // bool isLoadingImg = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoadingDialogController loadingDialogController =
      LoadingDialogController();

  // TextField Controllers to get data from TextFields

  // final profileImgUrl = Rxn<String>();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final schoolName = TextEditingController();

  var selectedGovernorate = Rxn<String>();
  var selectedGrade = Rxn<String>();
  var selectedDepartment = Rxn<String>();
  var selectedGender = Rxn<String>();
  var isSavingData = false.obs;

  int imageType = 0;

  File? file;

  String? profileImgUrl;

  String userId = FirebaseAuth.instance.currentUser!.uid;

  bool isProfileImgLoading = true;

  @override
  void onInit() async {
    // profileImgUrl.text = userController.user.value!.profileImgUrl;
    fullName.text = userController.user.value!.fullName;
    schoolName.text = userController.user.value!.schoolName;
    phoneNo.text = userController.user.value!.phoneNo;
    selectedGovernorate.value = userController.user.value!.selectedGovernorate;
    selectedGrade.value = userController.user.value!.selectedGrade;
    selectedGender.value = userController.user.value!.selectedGender;
    getProfileImage();

    super.onInit();
  }

  // Future<void> getVariables() async {}

  ImagePickerDialog(BuildContext context) {
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
                  imageType = 0;
                  saveImage(context);
                  Navigator.pop(context);

                  update();
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
                  imageType = 1;
                  saveImage(context);
                  Navigator.pop(context);

                  update();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  saveImage(BuildContext context) async {
    final XFile? changeProfileImage;

    imageType == 0
        ? changeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.gallery)
        : changeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.camera);
    if (changeProfileImage != null) {
      file = File(changeProfileImage.path);
    }
    // setState(() {});
    update();

    if (file == null) {
      Get.snackbar("Error", "No image selected");
      return;
    }

    try {
      loadingDialogController.showLoadingDialog(Get.context!);
      // Generate a unique filename using user ID and timestamp
      // Reference to Firebase Storage
      // final storageRef2 = FirebaseStorage.instance.refFromURL();
      final storageRef = FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$userId');

      // Upload the file
      await storageRef.putFile(file!);

      // Retrieve the download URL
      profileImgUrl = await storageRef.getDownloadURL();

      // Add Image Url To FireBase
      // await addImageProfile(
      //   userProfileImgUrl: 'user_profile_images/$userId',
      // );

      loadingDialogController.closeLoadingDialog(Get.context!);

      update();

      Get.snackbar("Success", "Image uploaded successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
    }
  }

  getProfileImage() async {
    try {
      isProfileImgLoading = true;
      update();

      profileImgUrl = await FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$userId')
          .getDownloadURL();

      isProfileImgLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserData() async {
    try {
      isSavingData.value = true;
      final updatedUser = UserModel(
        id: userController.user.value?.id,
        fullName: fullName.text.trim(),
        phoneNo: userController.user.value?.phoneNo ?? '',
        fakeEmail: userController.user.value?.fakeEmail ?? '',
        schoolName: schoolName.text.trim(),
        selectedGovernorate: userController.user.value?.selectedGovernorate,
        selectedGrade: userController.user.value?.selectedGrade,
        selectedGender: userController.user.value?.selectedGender,
        selectedDepartment: userController.user.value?.selectedDepartment,
      );

      await userController.updateUser(updatedUser);
      Helper.successSnackBar(
        title: "Success",
        message: "Profile updated successfully!",
      );
      isSavingData.value = false;
      Get.offAll(() => MenuScreen());
    } catch (e) {
      Helper.errorSnackBar(
        title: "Update Failed",
        message: e.toString().isNotEmpty
            ? e.toString()
            : "An unexpected error occurred. Please try again.",
      );
    }
  }
}
