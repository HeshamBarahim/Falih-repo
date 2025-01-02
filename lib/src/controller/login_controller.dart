import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/helper/helper_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'network_controller.dart';
import 'loading_dialog_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final NetworkController networkController = Get.put(NetworkController());

  final LoadingDialogController loadingDialogController =
      LoadingDialogController();

  /// TextField Controllers to get data from TextFields
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  RxBool isProcessing = false.obs;

  /// Loader
  final isLoading = false.obs;

  // EmailAndPasswordLogin
  Future<void> login(BuildContext context) async {
    // Generate a fake email using the phone number
    if (!isProcessing.value) {
      isProcessing.value = true;
      //   var result = await Connectivity().checkConnectivity();
      //   if (result == ConnectivityResult.mobile ||
      //       result == ConnectivityResult.wifi) {
      //     isConnected.value = true;
      //     // return true;
      //   } else {
      //     isConnected.value = false;
      //     // return false;
      //   }
      await networkController.checkConnection();
      // print('Connected: ${networkController.isConnected.value}');

      if (networkController.isConnected.value) {
        final fakeEmail = '${email.text.trim()}@gmail.com';
        try {
          if (!loginFormKey.currentState!.validate()) {
            isLoading.value = false;
            isProcessing.value = false;
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
          isProcessing.value = false;
        } catch (e) {
          loadingDialogController.closeLoadingDialog(Get.context!);

          Helper.errorSnackBar(title: "Oh Snap", message: e.toString());
          isProcessing.value = false;
        }
      } else {
        Get.snackbar(
          'Error', 'No Internet Connection',
          // snackStyle: SnackStyle.FLOATING
          // messageText: Text(
          //   'No Internet Connection',
          //   style: TextStyle(
          //     fontSize: 14.0,
          //     color: Color(0xFFFFFFFF),
          //   ),
          // ),
          // titleText: Text(
          //   'Error',
          //   style: TextStyle(
          //     color: Color(0xFFFFFFFF),
          //     fontSize: 14.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          isDismissible: true,
          dismissDirection: DismissDirection.endToStart,
          snackPosition: SnackPosition.TOP,
          shouldIconPulse: true,
          backgroundColor: Colors.red.shade600,
          duration: const Duration(seconds: 6),
          snackbarStatus: (status) {
            if (status case SnackbarStatus.CLOSED) {
              isProcessing.value = false;
            }
          },
          icon: Icon(
            Icons.wifi_off_rounded,
            color: Color(0xFFFFFFFF),
            size: 45.0,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        );
      }
    }
  }
}
