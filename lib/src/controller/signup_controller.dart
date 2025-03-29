import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart';
import 'loading_dialog_controller.dart';
import 'otp_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final _auth = AuthenticationRepository.instance;

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
  var isPrivacyChecked = false.obs;

  final UserRepository userRepository = Get.put(UserRepository());
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  var currentPageIndex = 1.obs;
  RxBool userNameError = false.obs;
  RxBool phoneError = false.obs;
  final isLoading = false.obs;

  String? profileImgUrl;
  int imageType = 0;
  File? file2;
  File? file;

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

  void saveImage(String userId) async {
    try {
      if (file2 != null) {
        loadingDialogController.showLoadingDialog();
        final storageRef = FirebaseStorage.instance
            .refFromURL('gs://falih-1.firebasestorage.app')
            .child('user_profile_images/$userId');

        // Upload the file
        await storageRef.putFile(file2!);
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

        loadingDialogController.closeLoadingDialog();
      }
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
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

  /// Register New User using either PhoneEmail and password
  Future<void> createUser() async {
    loadingDialogController.showLoadingDialog();
    try {
      isLoading.value = true;
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        loadingDialogController.closeLoadingDialog();
        return;
      }

      final otpController = Get.put(OtpController());
      otpController.phoneNo.value = phoneNo.text.trim();
      otpController.determineControllerType(1);
      if (await otpController.sendOtpToWhatsApp() == true) {
        Get.offNamed("otp-verification");
      } else {
        showErrorMessage(S.current.failed_send_ver_code);
        loadingDialogController.closeLoadingDialog();
      }
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      isLoading.value = false;
      if (e.toString() == 'Phone already exists.') {
        showErrorMessage(
            "The number is already in use. Please try a different number.");
      } else {
        print("Error: ${e.toString()}");
        showErrorMessage("Failed to create account. Please try again.");
      }
    }
  }

  addUser() async {
    final fakeEmail = '${phoneNo.text.trim()}@gmail.com';

    var user = UserModel(
      userProfileImgUrl: '',
      password: password.text.trim(),
      fullName: fullName.text.trim(),
      userName: userName.text.trim(),
      phoneNo: phoneNo.text.trim(),
      fakeEmail: fakeEmail,
      isVerified: 'true',
      schoolName: schoolName.text.trim(),
      selectedGovernorate: selectedGovernorate.value,
      selectedGrade: selectedGrade.value,
      selectedDepartment: selectedDepartment.value,
      selectedGender: selectedGender.value,
    );

    // Authenticate User first
    await _auth.registerWithEmailAndPassword(user.fakeEmail, user.password!);

    showSuccessMessage(
      message: S.current.create_account_successfully,
    );
    await UserRepository.instance.createUser(user);
    final userId = _auth.firebaseUser!.uid;
    saveImage(userId);

    // Update the user data in the controller

    final userData = await UserRepository.instance.getUserDetails();
    UserController.instance.setUser(userData);
  }

  checkUserName() async {
    try {
      loadingDialogController.showLoadingDialog();
      // Check if the username is unique
      QuerySnapshot<Map<String, dynamic>> userNameSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('UserName', isEqualTo: userName.text.trim())
              .limit(1)
              .get();

      if (userNameSnapshot.docs.isNotEmpty) {
        userNameError.value = true;
      } else {
        userNameError.value = false;
      }

      // Check if the phone number is unique
      QuerySnapshot<Map<String, dynamic>> phoneNoSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('Phone', isEqualTo: phoneNo.text.trim())
              .limit(1)
              .get();
      loadingDialogController.closeLoadingDialog();

      if (phoneNoSnapshot.docs.isNotEmpty) {
        phoneError.value = true;
      } else {
        phoneError.value = false;
      }

      if (!userNameError.value && !phoneError.value) {
        goToNextPage();
      }
    } catch (e) {
      throw const FormatException('Invalid username or data format');
    }
  }

  //  toggle the checkbox
  void toggleCheckbox(bool value) {
    isPrivacyChecked(value);
  }
}
