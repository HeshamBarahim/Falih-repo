import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../generated/l10n.dart';
import '../../config/themes.dart';
import '../../controller/loading_dialog_controller.dart';
import 'exceptions/t_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  late final Rx<User?> _firebaseUser;

  /// Firebase Instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final _phoneVerificationId = ''.obs;

  User? get firebaseUser => _firebaseUser.value;

  // Use this to store data locally
  final userStorage = GetStorage();
  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  /// Loads when app Launch from main.dart
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      setInitialScreen();
    });
  }

  /// Setting initial screen
  Future<void> setInitialScreen() async {
    if (_firebaseUser.value != null) {
      await checkDeviceAndLogoutOldDevice();

      // Ensure the user is still authenticated after the check
      if (_auth.currentUser != null) {
        Get.offAllNamed("main-screen");
      } else {
        Get.offAllNamed("login");
      }
    } else {
      bool isFirstTime = userStorage.read('isFirstTime') ?? true;
      if (isFirstTime) {
        userStorage.write('isFirstTime', false);
        Get.offAllNamed("onboarding");
      } else {
        Get.offAllNamed("login");
      }
    }
  }

  Future<void> saveDeviceToken() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final fcmToken = await _messaging.getToken();
    await _firestore.collection('users').doc(user.uid).set({
      'deviceToken': fcmToken,
    }, SetOptions(merge: true)); // Ensures existing data is not overwritten
  }

  Future<void> checkDeviceAndLogoutOldDevice() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final currentToken = await _messaging.getToken();
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final storedToken = userDoc.data()?['deviceToken'];

      if (storedToken != null && storedToken != currentToken) {
        await logout(); // Ensure logout completes before moving forward

        // Show logout message
        Get.snackbar(
          S.current.logoutFromMoreThanOneDeviceTitle,
          S.current.logoutFromMoreThanOneDevice,
          backgroundColor: Colors.white,
          colorText: AppColors.mainColor,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.notifications, color: AppColors.mainColor),
        );

        return; // Stop further execution to prevent unintended navigation
      } else {
        await saveDeviceToken();
      }
    } catch (e) {
      await logout(); // Ensure logout completes even on failure
    }
  }

// Email & Password sign-in

  // EmailAuthentication - LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await saveDeviceToken();
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } catch (_) {
      const result = TExceptions();
      throw result.message;
    }
  }

  //EmailAuthentication  - REGISTER
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  // EmailVerification  MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  // PhoneAuthentication VERIFY PHONE NO BY OTP
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: _phoneVerificationId.value, smsCode: otp),
    );
    return credentials.user != null ? true : false;
  }

  // LogoutUser
  Future<void> logout() async {
    loadingDialogController.showLoadingDialog();
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        await FirebaseAuth.instance.signOut();
        loadingDialogController.closeLoadingDialog();

        Get.offAll(() => Login());
      } on FirebaseAuthException catch (e) {
        loadingDialogController.closeLoadingDialog();
        throw e.message!;
      } on FormatException catch (e) {
        loadingDialogController.closeLoadingDialog();
        throw e.message;
      } catch (e) {
        loadingDialogController.closeLoadingDialog();
        throw 'Unable to logout. Try again.';
      }
    });
  }
}
