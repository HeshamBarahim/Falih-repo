import 'package:falih/src/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final user = Rxn<UserModel>();

  void setUser(UserModel userData) {
    user.value = userData;
  }

  UserModel? get currentUser => user.value;
}
