import 'package:get/get.dart';

import '../data/side_menu_data_list.dart';
import '../models/rive_asset.dart';

class NavBarController extends GetxController {
  RiveAsset selectedMenu = sideMenuDataList_1.first;
  bool isProcess = false;

  // var user;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // user = await UserRepository.instance.getUserDetails();
  }

  void selectMenu(RiveAsset menu) {
    selectedMenu = menu;
    update();
  }

  void startProcess() {
    isProcess = true;
    update();
  }

  void stopProcess() {
    isProcess = false;
    update();
  }
}
