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
      // Use Authentication ID (uID) as DocumentId for the "users" collection.
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw "User is not authenticated.";

      // Check if the record already exists based on email.
      final exists = await recordExist(user.fakeEmail);
      if (exists) throw "Record Already Exists";

      // Add user using uID as the document ID.
      await _db.collection("users").doc(uid).set(user.toJson());
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

  /// Fetch User Specific Details
  Future<UserModel> getUserDetails() async {
    try {
      // Use Authentication ID (uID) to fetch the specific user record.
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw "User is not authenticated.";

      final snapshot = await _db.collection("users").doc(uid).get();
      if (!snapshot.exists) throw 'No such user found';

      return UserModel.fromSnapshot(snapshot);
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

  /// Fetch All Users
  Future<List<UserModel>> allUsers() async {
    try {
      final snapshot = await _db.collection("users").get();
      final users =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return users;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Update User details
  Future<void> updateUserRecord(UserModel user) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw "User is not authenticated.";

      // Update the Firestore document with the new user data
      await _db.collection("users").doc(uid).update(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Delete User Data
  Future<void> deleteUser() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw "User is not authenticated.";

      await _db.collection("users").doc(uid).delete();
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Check if user exists with email or phoneNo
  Future<bool> recordExist(String fakeEmail) async {
    try {
      final snapshot = await _db
          .collection("users")
          .where("Email", isEqualTo: fakeEmail)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw "Error fetching record.";
    }
  }
}
