import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/sizes.dart';
import '../config/themes.dart';

class LoadingDialogController extends GetxController {
  void openLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        SizeConfig().init(context);
        return Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.04,
              vertical: SizeConfig.screenHeight! * 0.02,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: SizeConfig.screenWidth! * 0.008,
                  strokeAlign: SizeConfig.screenWidth! * 0.003,
                ),
                SizedBox(width: SizeConfig.screenWidth! * 0.06),
                Text(
                  "Loading...",
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: SizeConfig.screenWidth! * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void closeLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
