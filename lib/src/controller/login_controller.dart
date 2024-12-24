import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_dialog_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final LoadingDialogController loadingDialogController =
      LoadingDialogController();

  /// Loader
  final isLoading = false.obs;

  // EmailAndPasswordLogin
  Future<void> login(BuildContext context) async {
    // Generate a fake email using the phone number
    final fakeEmail = '${email.text.trim()}@gmail.com';

    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      loadingDialogController.showLoadingDialog(context);

      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(fakeEmail, password.text.trim());

      // Fetch the logged-in user's data
      final user = await UserRepository.instance.getUserDetails();

      // Store the user details in a UserController
      UserController.instance.setUser(user);
      // Set the initial screen
      auth.setInitialScreen(auth.firebaseUser);
      loadingDialogController.closeLoadingDialog(Get.context!);
    } catch (e) {
      loadingDialogController.closeLoadingDialog(Get.context!);

      isLoading.value = false;
      Helper.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
