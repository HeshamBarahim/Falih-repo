import 'package:falih/src/models/user_model.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final showPassword = false.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // TextField Controllers to get data from TextFields
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final schoolName = TextEditingController();

  var selectedGovernorate = Rxn<String>();
  var selectedGrade = Rxn<String>();

  final UserRepository userRepository = Get.put(UserRepository());

  /// Loader
  final isLoading = false.obs;

  /// Register New User using ither PhoneEmail and password
  Future<void> createUser() async {
    try {
      isLoading.value = true;
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
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
      );

      // Authenticate User first
      final auth = AuthenticationRepository.instance;
      await auth.registerWithEmailAndPassword(user.fakeEmail, user.password!);
      await UserRepository.instance.createUser(user);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
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
