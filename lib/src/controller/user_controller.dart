import 'package:falih/src/models/user_model.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  late var user = Rxn<UserModel>();
  // var profileImageUrl = ''.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    user.value = await UserRepository.instance.getUserDetails();
    // getProfileImage();
    super.onInit();
  }

  void setUser(UserModel userData) {
    user.value = userData;
  }

  // void setProfileImageUrl(String url) {
  //   profileImageUrl.value = url;
  // }

  // void getProfileImage() async {
  //   try {
  //     profileImageUrl.value = await FirebaseStorage.instance
  //         .refFromURL('gs://falih-1.firebasestorage.app')
  //         .child('user_profile_images/${user.value?.id}')
  //         .getDownloadURL();
  //   } catch (e) {
  //     print("No image fetched");
  //   }
  // }

  UserModel? get currentUser => user.value;

  Future<void> updateUser(UserModel updatedUser) async {
    try {
      await UserRepository.instance.updateUserRecord(updatedUser);
      setUser(updatedUser); // Update the local state with the new data
    } catch (e) {
      print("Error updating user: $e");
    }
  }
}
