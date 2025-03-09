import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes.dart';

class AboutUsScreenController extends GetxController {
  RxBool isLastPage = false.obs;
  RxBool isFirstPage = true.obs;
  RxInt currentViewsPageIndex = 0.obs;
  Rx<LinearGradient> currentLinearGradientColor =
      AppColors.aboutUsViewsBorderColor_1.obs;

}
