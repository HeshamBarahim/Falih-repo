import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repository/user_repository/user_repository.dart';
// import './profile_controller.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  // final ProfileController profileController = Get.put(ProfileController());

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

  // Future<void> setUserForProfileController() async {}

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
