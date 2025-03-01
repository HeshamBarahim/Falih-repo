import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/constants/dialogs.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../screens/main_screen/main_screen.dart';
import 'loading_dialog_controller.dart';
import 'network_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final NetworkController networkController = Get.put(NetworkController());
  final LoadingDialogController loadingDialogController =
      LoadingDialogController();

  RxBool isProcessing = false.obs;
  var isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    if (isProcessing.value) return; // Exit if already processing

    isProcessing.value = true;

    // Check network connection
    if (!await networkController.checkConnection()) {
      showErrorMessage('No Internet Connection');
      isProcessing.value = false;
      return;
    }

    // Validate form
    if (!loginFormKey.currentState!.validate()) {
      isProcessing.value = false;
      return;
    }

    try {
      loadingDialogController.showLoadingDialog(context);

      final input = email.text.trim();

      // Determine if the input is a phone number or username
      if (isNumeric(input)) {
        // Login with phone number
        await _loginWithPhoneNumber(input);
      } else {
        // Login with username
        await _loginWithUsername(input);
      }

      // Fetch and store user details
      final user = await UserRepository.instance.getUserDetails();
      UserController.instance.setUser(user);

      // Set initial screen based on user state
      final auth = AuthenticationRepository.instance;
      auth.setInitialScreen();

      // Navigate to the main screen
      Get.offAll(() => const MainScreen());
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      _handleFirebaseAuthError(e);
    } on FirebaseException catch (e) {
      // Handle Firestore errors
      showErrorMessage(S.current.wrong_credentials);
    } on FormatException catch (e) {
      // Handle invalid input format
      showErrorMessage('Invalid input: ${e.message}');
    } catch (e) {
      // Handle all other exceptions
      showErrorMessage('An unexpected error occurred: ${e.toString()}');
    } finally {
      loadingDialogController.closeLoadingDialog(Get.context!);
      isProcessing.value = false;
    }
  }

  /// Helper method to check if the input is numeric (phone number)
  bool isNumeric(String input) {
    return int.tryParse(input) != null;
  }

  /// Login with phone number
  Future<void> _loginWithPhoneNumber(String phoneNumber) async {
    try {
      final fakeEmail = '$phoneNumber@gmail.com'; // Append a fake domain
      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(fakeEmail, password.text.trim());
    } on FirebaseAuthException catch (e) {
      // Re-throw FirebaseAuthException to be handled in the main login method
      rethrow;
    } catch (e) {
      // Handle other exceptions (e.g., invalid email format)
      throw FirebaseException(
        plugin: 'firestore',
        message: 'User not found',
      );
    }
  }

  /// Login with username
  Future<void> _loginWithUsername(String username) async {
    try {
      // Fetch the associated phone number from Firestore
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('UserName', isEqualTo: username)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw FirebaseException(
          plugin: 'firestore',
          message: 'User not found',
        );
      }

      final phoneNumber = querySnapshot.docs[0]['Phone'];
      await _loginWithPhoneNumber(phoneNumber); // Reuse phone login logic
    } on FirebaseException catch (e) {
      // Re-throw Firestore exceptions to be handled in the main login method
      rethrow;
    } catch (e) {
      // Handle other exceptions (e.g., invalid data format)
      throw const FormatException('Invalid username or data format');
    }
  }

  /// Handle Firebase authentication errors
  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'Invalid email format';
        break;
      case 'user-not-found':
        errorMessage = 'User not found';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Try again later';
        break;
      default:
        errorMessage = 'Authentication failed: ${e.message}';
    }
    showErrorMessage(errorMessage);
  }
}
