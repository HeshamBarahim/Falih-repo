import 'package:get/get.dart';

class NavBarController extends GetxController {
  bool isProcess = false;

  // var user;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // user = await UserRepository.instance.getUserDetails();
  }

  void startProcess(int index) {
    isProcess = true;
    update();
  }

  void stopProcess(int index) {
    isProcess = false;
    update();
  }
}
