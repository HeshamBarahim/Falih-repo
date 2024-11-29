import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falih/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../authentication_repository/exceptions/t_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Store user data
  Future<void> createUser(UserModel user) async {
    try {
      // await recordExist(user.email)
      // ? throw "Record Already Exists"
      await _db.collection("users").add(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  /// Check if user exists with email or phoneNo
// Future<bool> recordExist(String email) async {
//   try {
//     final snapshot =
//         await _db.collection("users").where("Email", isEqualTo: email).get();
//     return snapshot.docs.isEmpty ? false : true;
//   } catch (e) {
//     throw "Error fetching record.";
//   }
// }
}
