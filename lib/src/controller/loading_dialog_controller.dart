import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/sizes.dart';
import '../config/themes.dart';

class LoadingDialogController extends GetxController {
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        SizeConfig().init(context);
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              // Navigate to the menu screen when the user tries to pop
              Get.snackbar("Error", "Wait For The Prosess");
            }
          },
          child: Dialog(
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
          ),
        );
      },
    );
  }

  void closeLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
