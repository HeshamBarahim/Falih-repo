import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:falih/src/screens/Auth/otp/otp_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';

import '../../generated/l10n.dart';
import 'loading_dialog_controller.dart';
import 'otp_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final profile = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();
  final fullName = TextEditingController();
  final userName = TextEditingController();
  final phoneNo = TextEditingController();
  final schoolName = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final showPassword = false.obs;
  var selectedGovernorate = Rxn<String>();
  var selectedGrade = Rxn<String>();
  var selectedDepartment = Rxn<String>();
  var selectedGender = Rxn<String>();
  final UserRepository userRepository = Get.put(UserRepository());
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  RxBool userNameError = false.obs;
  RxString userNameErrorMessage = S.current.username_already_exists.obs;

  String? profileImgUrl;

  int imageType = 0;

  File? file2;
  File? file;

  /// Loader
  final isLoading = false.obs;

  // Tracks the current page to manage the split screens of signup
  var currentPageIndex = 1.obs;

  imagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Directionality(
            textDirection: Get.locale?.languageCode == "ar"
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Column(
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
                    picTheImage(context);
                    // saveImage(context);
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
                    // saveImage(context);
                    picTheImage(context);
                    Navigator.pop(context);

                    update();
                  },
                ),
              ],
            ),
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

  picTheImage(BuildContext context) async {
    file = null;
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
        file2 = compressedFile;
      } else {
        file2 = selectedFile;
      }
    }
    // setState(() {});
    update();

    if (file2 == null) {
      Get.snackbar(S.current.error, S.current.no_image_selected);
      return;
    }
  }

  saveImage(String userId) async {
    try {
      loadingDialogController.showLoadingDialog();
      // Generate a unique filename using user ID and timestamp
      // Reference to Firebase Storage
      // final storageRef2 = FirebaseStorage.instance.refFromURL();
      final storageRef = FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$userId');

      // Upload the file
      await storageRef.putFile(file2!);

      // Retrieve the download URL
      profileImgUrl = await storageRef.getDownloadURL();

      try {
        // Add Image Url To FireBase
        CollectionReference imgUrlCollection =
            FirebaseFirestore.instance.collection('users');

        await imgUrlCollection
            .doc(userId)
            .update({'userProfileImgUrl': profileImgUrl})
            .then((value) => print("Image Edited"))
            .catchError((error) {
              print("Failed to Edit Note: $error");
            });
        update();
      } on FirebaseAuthException catch (e) {
        throw e.message.toString();
      }

      // await updateUserProfileImgUrl(profileImgUrl!);
      // update();
      loadingDialogController.closeLoadingDialog();

      // Get.snackbar("Success", "Image uploaded successfully");
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      Get.snackbar(S.current.error, "${S.current.failed_upload_image}: $e");
    }
  }

  void goToNextPage() {
    if (currentPageIndex.value < 2) {
      currentPageIndex.value++;
    }
  }

  void goToPreviousPage() {
    if (currentPageIndex.value > 1) {
      currentPageIndex.value--;
    }
  }

  /// Register New User using ither PhoneEmail and password
  Future<void> createUser(BuildContext context) async {
    loadingDialogController.showLoadingDialog();
    try {
      isLoading.value = true;
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        loadingDialogController.closeLoadingDialog();
        return;
      }

      // Generate a fake email using the phone number
      final fakeEmail = '${phoneNo.text.trim()}@gmail.com';

      /// For Phone Authentication
      // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
      // Get.to(() => const OTPScreen());

      // Get User and Pass it to Controller
      final user = UserModel(
        userProfileImgUrl: '',
        password: password.text.trim(),
        fullName: fullName.text.trim(),
        userName: userName.text.trim(),
        phoneNo: phoneNo.text.trim(),
        fakeEmail: fakeEmail,
        isVerified: 'false',
        schoolName: schoolName.text.trim(),
        selectedGovernorate: selectedGovernorate.value,
        selectedGrade: selectedGrade.value,
        selectedDepartment: selectedDepartment.value,
        selectedGender: selectedGender.value,
      );

      // Authenticate User first
      final auth = AuthenticationRepository.instance;
      await auth.registerWithEmailAndPassword(user.fakeEmail, user.password!);

      await UserRepository.instance.createUser(user);
      final userId = auth.firebaseUser!.uid;
      // auth.setInitialScreen(auth.firebaseUser);
      saveImage(userId);
      loadingDialogController.closeLoadingDialog();
      // Redirect to the login screen

      showSuccessMessage(message: "Account created successfully!");
      final otpController = Get.put(OtpController());
      otpController.phoneNo.value = phoneNo.text.trim();
      otpController.determineControllerType(1);
      otpController.sendOTP();

      Get.offAll(() => OTPVerification());
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      isLoading.value = false;
      showErrorMessage("Failed to create account. Please try again.");
    }
  }

  showUserNameErrorMessage() async {
    try {
      loadingDialogController.showLoadingDialog();
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('UserName', isEqualTo: userName.text.trim())
              .limit(1)
              .get();
      loadingDialogController.closeLoadingDialog();

      if (querySnapshot.docs.isNotEmpty) {
        userNameError.value = true;
      } else {
        userNameError.value = false;
        goToNextPage();
      }
    } catch (e) {
      throw const FormatException('Invalid username or data format');
    }
  }

  //PhoneNoAuthentication
  // Future<void> phoneAuthentication(String phoneNo) async {
  //   try {
  //     await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  //  manage checkbox state
  var isChecked = false.obs;

  //  toggle the checkbox
  void toggleCheckbox(bool value) {
    isChecked(value);
  }
}
