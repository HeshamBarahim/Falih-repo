import 'package:falih/src/models/user_model.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_dialog_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // Tracks the current page
  var currentPageIndex = 1.obs;

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

  final showPassword = false.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // TextField Controllers to get data from TextFields
  final profile = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final schoolName = TextEditingController();

  var selectedGovernorate = Rxn<String>();
  var selectedGrade = Rxn<String>();
  var selectedDepartment = Rxn<String>();
  var selectedGender = Rxn<String>();
  final UserRepository userRepository = Get.put(UserRepository());
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  /// Loader
  final isLoading = false.obs;

  /// Register New User using ither PhoneEmail and password
  Future<void> createUser(BuildContext context) async {
    loadingDialogController.showLoadingDialog(context);
    try {
      isLoading.value = true;
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        loadingDialogController.closeLoadingDialog(context);
        return;
      }

      // Generate a fake email using the phone number
      final fakeEmail = '${phoneNo.text.trim()}@gmail.com';

      /// For Phone Authentication
      // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
      // Get.to(() => const OTPScreen());

      // Get User and Pass it to Controller
      final user = UserModel(
        password: password.text.trim(),
        fullName: fullName.text.trim(),
        phoneNo: phoneNo.text.trim(),
        fakeEmail: fakeEmail,
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
      auth.setInitialScreen(auth.firebaseUser);
      loadingDialogController.closeLoadingDialog(context);
    } catch (e) {
      loadingDialogController.closeLoadingDialog(context);
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
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
