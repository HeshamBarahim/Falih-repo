import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/main_screen/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/loading_dialog_controller.dart';
import '../../screens/on_boarding/first_page_boarding.dart';
import 'exceptions/t_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;
  final _phoneVerificationId = ''.obs;
  // Use this to store data locally
  final userStorage = GetStorage();

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setInitialScreen(_firebaseUser.value);
      isAuthCheckComplete.value = true;
    });
  }

  /// Setting initial screen
  setInitialScreen(User? user) async {
    await Future.delayed(
        const Duration(milliseconds: 100)); // Delay to ensure proper navigation

    if (user != null) {
      Get.offAll(() => MenuScreen());
    } else {
      userStorage.writeIfNull('isFirstTime', true);

      bool isFirstTime = userStorage.read('isFirstTime') ?? true;
      if (isFirstTime) {
        Get.offAll(() => FirstPageBoarding());
      } else {
        Get.offAll(() => Login());
      }
    }
  }

// Email & Password sign-in

  // EmailAuthentication - LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
  Future<void> logout(BuildContext context) async {
    loadingDialogController.showLoadingDialog(context);
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        await FirebaseAuth.instance.signOut();
        loadingDialogController.closeLoadingDialog(Get.context!);

        Get.offAll(() => Login());
      } on FirebaseAuthException catch (e) {
        loadingDialogController.closeLoadingDialog(Get.context!);
        throw e.message!;
      } on FormatException catch (e) {
        loadingDialogController.closeLoadingDialog(Get.context!);
        throw e.message;
      } catch (e) {
        loadingDialogController.closeLoadingDialog(Get.context!);
        throw 'Unable to logout. Try again.';
      }
    });
  }
}
