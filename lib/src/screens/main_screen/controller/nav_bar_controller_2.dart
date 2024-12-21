import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../../generated/l10n.dart';
import '../../curriculum/curriculum_page.dart';
import '../../home/home_page.dart';
import '../../leaderboard/leaderboard_screen.dart';
import '../utils/rive_utils.dart';

class NavBarController2 extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  rive.SMIBool? isSideBarClosed;

  var bottomNavBarVisibility = true.obs;
  var isSideNavBarClosed = true.obs;
  var lastBackPressTime;

  var selectedIndex = 1.obs;

}
