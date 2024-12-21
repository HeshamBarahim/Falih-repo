import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes.dart';

class AboutUsScreenContoller extends GetxController {
  final pageController = PageController();

  RxBool isLastPage = false.obs;
  RxBool isFirstPage = true.obs;
  RxInt currentViewsPageIndex = 0.obs;
  Rx<LinearGradient> currentLinearGradientColor =
      AppColors.aboutUsViewsBorderColor_1.obs;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
