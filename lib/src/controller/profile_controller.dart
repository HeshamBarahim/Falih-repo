import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  var userProfileImgUrl = Rxn<String>();

  var selectedGovernorate = Rxn<String>();
  var selectedGrade = Rxn<String>();
  var selectedDepartment = Rxn<String>();
  var selectedGender = Rxn<String>();
  var isSavingData = false.obs;

  int imageType = 0;

  File? file;

  String userId = FirebaseAuth.instance.currentUser!.uid;

  bool isProfileImgLoading = true;

  // bool isProfileImgLoading = true;

  int imgInit = 0;

  String? profileImgUrl;

  @override
  void onInit() async {
    isProfileImgLoading = true;
    update();
    await getVariables();
    isProfileImgLoading = false;
    update();

    super.onInit();
  }

  Future<void> getVariables() async {
    userProfileImgUrl.value = userController.user.value!.userProfileImgUrl;
    fullName.text = userController.user.value!.fullName;
    schoolName.text = userController.user.value!.schoolName;
    phoneNo.text = userController.user.value!.phoneNo;
    selectedGovernorate.value = userController.user.value!.selectedGovernorate;
    selectedGrade.value = userController.user.value!.selectedGrade;
    selectedGender.value = userController.user.value!.selectedGender;
  }

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
      await edituserProfileImgUrl(profileImgUrl!);

      await updateUserProfileImgUrl(profileImgUrl!);
      update();
      loadingDialogController.closeLoadingDialog(Get.context!);

      // Get.snackbar("Success", "Image uploaded successfully");
    } catch (e) {
      loadingDialogController.closeLoadingDialog(Get.context!);
      Get.snackbar("Error", "Failed to upload image: $e");
    }
  }

  Future<void> edituserProfileImgUrl(String url) async {
    CollectionReference imgUrlCollection =
        FirebaseFirestore.instance.collection('users');

    await imgUrlCollection
        .doc(userId)
        .update({'userProfileImgUrl': url})
        .then((value) => print("Image Edited"))
        .catchError((error) {
          print("Failed to Edit Note: $error");
        });
    update();
  }

  Future<void> updateUserProfileImgUrl(String url) async {
    try {
      isSavingData.value = true;
      final updatedUser = UserModel(
          id: userController.user.value!.id,
          userProfileImgUrl: url,
          fullName: userController.user.value!.fullName,
          phoneNo: userController.user.value!.phoneNo,
          fakeEmail: userController.user.value!.fakeEmail,
          schoolName: userController.user.value!.schoolName,
          selectedGovernorate: userController.user.value!.selectedGovernorate,
          selectedGrade: userController.user.value!.selectedGrade,
          selectedGender: userController.user.value!.selectedGender,
          selectedDepartment: userController.user.value!.selectedDepartment);

      await userController.updateUser(updatedUser);

      await userController.updateUser(updatedUser);
      Helper.successSnackBar(
        title: "Success",
        message: "Profile Image updated successfully!",
      );
      isSavingData.value = false;
      // Get.offAll(() => MenuScreen());
      // Get.offAll(MenuScreen());
      userProfileImgUrl.value = url;
      update();

    } catch (e) {
      Helper.errorSnackBar(
        title: "Update Failed",
        message: e.toString().isNotEmpty
            ? e.toString()
            : "An unexpected error occurred. Please try again.",
      );
    }
  }

  Future<void> updateUserData() async {
    try {
      isSavingData.value = true;
      final updatedUser = UserModel(
        id: userController.user.value?.id,
        userProfileImgUrl: userController.user.value!.userProfileImgUrl,
        fullName: fullName.text.trim(),
        phoneNo: userController.user.value!.phoneNo,
        fakeEmail: userController.user.value!.fakeEmail,
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
