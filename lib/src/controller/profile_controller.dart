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

class ProfileController extends GetxController {
  final UserController userController = Get.put(UserController());
  final showPassword = false.obs;
  // bool isLoadingImg = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TextField Controllers to get data from TextFields
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
  var profileImgUrl = Rxn<String>();
  String? fileExtension;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    fullName.text = userController.user.value!.fullName;
    schoolName.text = userController.user.value!.schoolName;
    phoneNo.text = userController.user.value!.phoneNo;
    selectedGovernorate.value = userController.user.value!.selectedGovernorate;
    selectedGrade.value = userController.user.value!.selectedGrade;
    selectedGender.value = userController.user.value!.selectedGender;
  }

  saveImage() async {
    final XFile? changeProfileImage;
    imageType == 0
        ? changeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.gallery)
        : changeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.camera);
    if (changeProfileImage != null) {
      file = File(changeProfileImage.path);
      fileExtension = path.extension(changeProfileImage.path);
    }

    if (file == null) {
      Get.snackbar("Error", "No image selected");
      return;
    }

    try {
      // Generate a unique filename using user ID and timestamp
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String fileName = '$userId $fileExtension';

      // Reference to Firebase Storage
      // final storageRef2 = FirebaseStorage.instance.refFromURL();
      final storageRef = FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$fileName');

      // Upload the file
      await storageRef.putFile(file!);

      // Retrieve the download URL
      profileImgUrl.value = await storageRef.getDownloadURL();
      // Update UserController
      userController.setProfileImageUrl(profileImgUrl.value!);

      Get.snackbar("Success", "Image uploaded successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
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
