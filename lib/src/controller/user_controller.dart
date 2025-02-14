import 'package:falih/src/constants/dialogs.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../models/user_model.dart';
import '../repository/user_repository/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  late var user = Rxn<UserModel>();

  @override
  Future<void> onInit() async {
    try {
      user.value = await UserRepository.instance.getUserDetails();
    } catch (e) {
      showErrorMessage(S.current.unexpected_error_occured);
      return;
    }
    // getProfileImage();
    super.onInit();
  }

  void setUser(UserModel userData) {
    user.value = userData;
  }

  UserModel? get currentUser => user.value;

  Future<void> updateUser(UserModel updatedUser) async {
    try {
      await UserRepository.instance.updateUserRecord(updatedUser);
      setUser(updatedUser); // Update the local state with the new data
    } catch (e) {
      showErrorMessage("لم يتم تحديث بياناتك بنجاح");
    }
  }
}
