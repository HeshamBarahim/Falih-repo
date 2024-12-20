import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/main_screen/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/loading_dialog_controller.dart';
import '../../screens/on_boarding/first_page_boarding.dart';
import 'exceptions/t_exceptions.dart';

/// -- README(Docs[6]) -- Bindings
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;
  final _phoneVerificationId = ''.obs;
  final userStorage =
      GetStorage(); // Use this to store data locally (e.g. OnBoarding)

  /// Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => firebaseUser?.uid ?? "";

  String get getUserEmail => firebaseUser?.email ?? "";

  String get getDisplayName => firebaseUser?.displayName ?? "";

  String get getPhoneNo => firebaseUser?.phoneNumber ?? "";

  RxBool isAuthCheckComplete = false.obs;

  final LoadingDialogController loadingDialogController =
      Get.put(LoadingDialogController());

  /// Loads when app Launch from main.dart
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    // FlutterNativeSplash.remove();
    setInitialScreen(_firebaseUser.value);
    isAuthCheckComplete.value = true; // Mark auth check as complete

    // ever(_firebaseUser, _setInitialScreen);
  }

  /// Setting initial screen
  setInitialScreen(User? user) async {
    if (user != null) {
      Get.offAll(() => MenuScreen());
    } else {
      // Check if it's the user's first time, then navigate accordingly
      userStorage.writeIfNull('isFirstTime', true);
      print(userStorage.read('isFirstTime'));
      userStorage.read('isFirstTime') != true
          ? Get.offAll(() => Login())
          : Get.offAll(() => FirstPageBoarding());
    }
  }

// Email & Password sign-in

  // EmailAuthentication - LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final result =
          TExceptions.fromCode(e.code); // Throw custom [message] variable
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
  Future<void> logout(BuildContext context) async {
    loadingDialogController.openLoadingDialog(context);
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        await FirebaseAuth.instance.signOut();
        loadingDialogController.closeLoadingDialog(context);

        Get.offAll(() => Login());
      } on FirebaseAuthException catch (e) {
        loadingDialogController.closeLoadingDialog(context);
        throw e.message!;
      } on FormatException catch (e) {
        loadingDialogController.closeLoadingDialog(context);
        throw e.message;
      } catch (e) {
        loadingDialogController.closeLoadingDialog(context);
        throw 'Unable to logout. Try again.';
      }
    });
  }
}
