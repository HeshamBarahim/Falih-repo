import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/auth_backend.dart';

enum DeleteAccountResult { success, wrongPassword, failed }

class WrongPasswordException implements Exception {
  const WrongPasswordException();
}

/// Deletes the signed-in user's account: confirm the password, let the server
/// remove everything, then sign out. The server insists on a recent login, so
/// the password check is not just a UI nicety.
class AccountDeletionController extends GetxController {
  AccountDeletionController({
    AuthBackend? backend,
    Future<void> Function(String password)? reauthenticate,
    Future<void> Function()? signOut,
  })  : _backend = backend ?? CloudAuthBackend(),
        _reauthenticate = reauthenticate ?? _firebaseReauthenticate,
        _signOut = signOut ?? (() => FirebaseAuth.instance.signOut());

  final AuthBackend _backend;
  final Future<void> Function(String password) _reauthenticate;
  final Future<void> Function() _signOut;

  final isDeleting = false.obs;

  static Future<void> _firebaseReauthenticate(String password) async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    if (user == null || email == null) throw const WrongPasswordException();
    try {
      await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential' ||
          e.code == 'invalid-login-credentials') {
        throw const WrongPasswordException();
      }
      rethrow;
    }
  }

  Future<DeleteAccountResult> deleteAccount(String password) async {
    if (isDeleting.value) return DeleteAccountResult.failed;
    if (password.trim().isEmpty) return DeleteAccountResult.wrongPassword;
    isDeleting.value = true;
    try {
      await _reauthenticate(password);
      await _backend.deleteAccount();
      await _signOut();
      return DeleteAccountResult.success;
    } on WrongPasswordException {
      return DeleteAccountResult.wrongPassword;
    } catch (_) {
      return DeleteAccountResult.failed;
    } finally {
      isDeleting.value = false;
    }
  }
}
