import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:falih/src/services/auth_backend.dart';
import 'package:falih/src/services/auth_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import 'loading_dialog_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  LoginController({AuthBackend? backend})
      : _backend = backend ?? CloudAuthBackend();

  final AuthBackend _backend;

  /// TextField Controllers to get data from TextFields
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // final NetworkController networkController = Get.put(NetworkController());
  final LoadingDialogController loadingDialogController =
      LoadingDialogController();

  RxBool isProcessing = false.obs;
  var isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    if (isProcessing.value) return; // Exit if already processing

    // Validate form
    if (!loginFormKey.currentState!.validate()) return;

    isProcessing.value = true;
    loadingDialogController.showLoadingDialog();
    var dialogOpen = true;
    void closeDialog() {
      if (dialogOpen) {
        dialogOpen = false;
        loadingDialogController.closeLoadingDialog();
      }
    }

    try {
      // The server turns a phone number or username into the Firebase email,
      // so the app never builds emails or queries other users' documents.
      final loginEmail = await _backend.lookupLoginEmail(email.text.trim());
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(loginEmail, password.text.trim());

      // Fetch and store user details
      final user = await UserRepository.instance.getUserDetails();
      UserController.instance.setUser(user);

      // Set initial screen based on user state
      await AuthenticationRepository.instance.setInitialScreen();
    } on FirebaseAuthException catch (e) {
      closeDialog();
      _handleFirebaseAuthError(e);
    } on AuthFailure catch (e) {
      closeDialog();
      showErrorMessage(authErrorMessage(e));
    } on FirebaseException {
      closeDialog();
      showErrorMessage(S.current.wrong_credentials);
    } catch (e) {
      closeDialog();
      showErrorMessage(S.current.unexpected_error_occured);
    } finally {
      isProcessing.value = false;
    }
  }

  /// Handle Firebase authentication errors
  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'network-request-failed':
        errorMessage = S.current.no_internet_connection;
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Try again later'; // TODO(l10n)
        break;
      default:
        // invalid-credential, user-not-found, wrong-password, invalid-email:
        // one message, so the app does not reveal which accounts exist.
        errorMessage = S.current.wrong_credentials;
    }
    showErrorMessage(errorMessage);
  }
}
