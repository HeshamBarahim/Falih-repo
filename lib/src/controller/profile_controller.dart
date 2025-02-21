import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/generated/l10n.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/helper_controller.dart';
import '../models/user_model.dart';
import '../screens/main_screen/main_screen.dart';
import 'loading_dialog_controller.dart';

class ProfileController extends GetxController {
  final UserController userController = Get.put(UserController());
  final showPassword = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoadingDialogController loadingDialogController =
      LoadingDialogController();

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
    selectedDepartment.value = userController.user.value!.selectedDepartment;
  }

  imagePickerDialog(BuildContext context) {
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
                title: Text(
                  S.of(context).upload_image,
                  style: const TextStyle(
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
                title: Text(
                  S.of(context).take_photo,
                  style: const TextStyle(
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

  Future<File?> compressImage(File file) async {
    final filePath = file.absolute.path;

    // Define the output file path
    final lastIndex = filePath.lastIndexOf('.');
    final splitPath = filePath.substring(0, lastIndex);
    final outPath = "${splitPath}_compressed.jpg";

    // Compress the image
    final result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 50, // Reduce quality (adjust if necessary)
    );

    return result != null ? File(result.path) : file;
  }

  saveImage(BuildContext context) async {
    final XFile? changeProfileImage;

    imageType == 0
        ? changeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.gallery)
        : changeProfileImage =
            await ImagePicker().pickImage(source: ImageSource.camera);
    if (changeProfileImage != null) {
      File selectedFile = File(changeProfileImage.path);

      // file = File(changeProfileImage.path);
      // Get file size
      int fileSize = await selectedFile.length();
      double fileSizeMB = fileSize / (1024 * 1024); // Convert to MB

      if (fileSizeMB >= 1.0) {
        // Compress if file is larger than 1MB
        File? compressedFile = await compressImage(selectedFile);
        file = compressedFile;
      } else {
        file = selectedFile;
      }
    }
    // setState(() {});
    update();

    if (file == null) {
      Get.snackbar(S.current.error, S.current.no_image_selected);
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

      file = null;

      // Get.snackbar("Success", "Image uploaded successfully");
    } catch (e) {
      loadingDialogController.closeLoadingDialog(Get.context!);
      Get.snackbar(S.current.error, "${S.current.failed_upload_image}: $e");
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
          fullName: userController.user.value!.fullName,
          userName: userController.user.value?.userName ?? '',
          userProfileImgUrl: url,
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
        title: S.current.success,
        message: S.current.profile_image_updated_successfully,
      );
      isSavingData.value = false;
      userProfileImgUrl.value = url;
      update();
    } catch (e) {
      Helper.errorSnackBar(
        title: S.current.updated_failed,
        message: e.toString().isNotEmpty
            ? e.toString()
            : S.current.unexpected_error_occured,
      );
    }
  }

  Future<void> updateUserData() async {
    try {
      isSavingData.value = true;
      final updatedUser = UserModel(
        id: userController.user.value?.id,
        fullName: fullName.text.trim(),
        userName: userController.user.value?.userName ?? '',
        userProfileImgUrl: userProfileImgUrl.value?.trim(),
        phoneNo: phoneNo.text.trim(),
        fakeEmail: userController.user.value!.fakeEmail,
        schoolName: schoolName.text.trim(),
        selectedGovernorate: selectedGovernorate.value?.trim(),
        selectedGrade: selectedGrade.value?.trim(),
        selectedGender: selectedGender.value?.trim(),
        selectedDepartment: selectedDepartment.value?.trim(),
      );

      await userController.updateUser(updatedUser);
      Helper.successSnackBar(
        title: S.current.success,
        message: S.current.profile_updated_successfully,
      );
      isSavingData.value = false;
      Get.offAll(() => MainScreen());
    } catch (e) {
      Helper.errorSnackBar(
        title: S.current.updated_failed,
        message: e.toString().isNotEmpty
            ? e.toString()
            : S.current.unexpected_error_occured,
      );
    }
  }
}
