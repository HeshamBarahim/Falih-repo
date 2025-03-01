import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../config/sizes.dart';
import '../config/themes.dart';

class LoadingDialogController extends GetxController {
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        SizeConfig().init(context);
        return GetBuilder<LoadingDialogController>(
          builder: (_) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  Get.snackbar(S.current.error, S.current.wait_process_error);
                }
              },
              child: Dialog(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: SizeConfig.screenWidth! * 0.8,
                    // Set maximum width (80% of screen width)
                    minWidth: SizeConfig.screenWidth! *
                        0.5, // Set minimum width (50% of screen width)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.04,
                      vertical: SizeConfig.screenHeight! * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Center the content horizontally
                      mainAxisSize: MainAxisSize.min,
                      // Ensure the Row doesn't expand unnecessarily
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: SizeConfig.screenWidth! * 0.008,
                          strokeAlign: SizeConfig.screenWidth! * 0.003,
                        ),
                        SizedBox(width: SizeConfig.screenWidth! * 0.04),
                        // Add spacing between the indicator and text
                        Text(
                          S.current.loading_text, // سيتم تحديثه عند تغيير اللغة
                          textAlign: TextAlign.right,
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
              ),
            );
          },
        );
      },
    );
  }

  void closeLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
