import 'package:get/get.dart';

import '../data/side_menu_data_list.dart';
import '../models/rive_asset.dart';

class NavBarTileController extends GetxController {
  RiveAsset selectedMenu = sideMenuDataList_1.first;
  bool isProcess = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
