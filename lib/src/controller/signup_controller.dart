import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:falih/src/services/auth_backend.dart';
import 'package:falih/src/services/auth_messages.dart';
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
  AuthenticationRepository get _auth => AuthenticationRepository.instance;
  final AuthBackend _backend;

  SignUpController({AuthBackend? backend})
      : _backend = backend ?? CloudAuthBackend();

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

  /// Best-effort profile image upload; the account already exists at this point.
  Future<void> saveImage(String userId) async {
    final image = file2;
    if (image == null) return;
    try {
      final storageRef = FirebaseStorage.instance
          .refFromURL('gs://falih-1.firebasestorage.app')
          .child('user_profile_images/$userId');
      await storageRef.putFile(image);
      profileImgUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'userProfileImgUrl': profileImgUrl});
    } catch (e) {
      debugPrint('Profile image upload failed: $e');
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

  /// Step 1 of signup: validate the form, then ask the server to send a code.
  Future<void> createUser() async {
    if (!signupFormKey.currentState!.validate()) return;
    loadingDialogController.showLoadingDialog();
    isLoading.value = true;
    try {
      final otpController = Get.put(OtpController());
      otpController.phoneNo.value = phoneNo.text.trim();
      otpController.determineControllerType(1);
      if (await otpController.sendOtp()) {
        // Replaces the loading dialog route and shows the OTP page.
        Get.offNamed("otp-verification");
      } else {
        loadingDialogController.closeLoadingDialog();
        showErrorMessage(authErrorMessage(otpController.lastFailure));
      }
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(S.current.unexpected_error_occured);
    } finally {
      isLoading.value = false;
    }
  }

  /// Step 2 of signup: the server checks the code and creates the account;
  /// then we sign in with the returned email.
  Future<void> completeSignup(String challengeId, String code) async {
    loadingDialogController.showLoadingDialog();
    try {
      final email = await _backend.completeSignup(
        challengeId: challengeId,
        code: code,
        password: password.text.trim(),
        profile: {
          'fullName': fullName.text.trim(),
          'userName': userName.text.trim(),
          'schoolName': schoolName.text.trim(),
          'governorate': selectedGovernorate.value,
          'grade': selectedGrade.value,
          'department': selectedDepartment.value,
          'gender': selectedGender.value,
        },
      );
      await _auth.loginWithEmailAndPassword(email, password.text.trim());
      final userId = _auth.firebaseUser?.uid ??
          FirebaseAuth.instance.currentUser!.uid;
      await saveImage(userId);
      UserController.instance
          .setUser(await UserRepository.instance.getUserDetails());
      loadingDialogController.closeLoadingDialog();
      showSuccessMessage(message: S.current.create_account_successfully);
      await _auth.setInitialScreen();
    } on AuthFailure catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(authErrorMessage(e));
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(S.current.unexpected_error_occured);
    }
  }

  /// Signup page 1: are the username and phone free? Answered by the server,
  /// so the app needs no read access to other users' documents.
  Future<void> checkUserName() async {
    loadingDialogController.showLoadingDialog();
    try {
      final result = await _backend.checkAvailability(
        userName: userName.text.trim(),
        phone: phoneNo.text.trim(),
      );
      loadingDialogController.closeLoadingDialog();
      userNameError.value = result.userNameTaken ?? false;
      phoneError.value = result.phoneTaken ?? false;
      if (!userNameError.value && !phoneError.value) goToNextPage();
    } on AuthFailure catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(authErrorMessage(e));
    } catch (e) {
      loadingDialogController.closeLoadingDialog();
      showErrorMessage(S.current.unexpected_error_occured);
    }
  }

  //  toggle the checkbox
  void toggleCheckbox(bool value) {
    isPrivacyChecked(value);
  }
}
