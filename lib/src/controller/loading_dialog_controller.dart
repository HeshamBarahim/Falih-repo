import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../config/sizes.dart';

class LoadingDialogController extends GetxController {
  void showLoadingDialog() {
    showDialog(
      context: Get.context!,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Check if the current locale is Arabic, and reverse the order of widgets accordingly
                          if (Get.locale?.languageCode == 'ar') ...[
                            // Arabic language: reverse the order of the widgets
                            Text(
                              S.current.loading_text,
                              textDirection: TextDirection.ltr,
                            ),
                            SizedBox(width: SizeConfig.screenWidth! * 0.04),
                            CircularProgressIndicator(
                              strokeWidth: SizeConfig.screenWidth! * 0.008,
                              strokeAlign: SizeConfig.screenWidth! * 0.003,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ] else ...[
                            // Default (LTR) language: use the original order

                            Text(
                              S.current.loading_text,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(width: SizeConfig.screenWidth! * 0.04),
                            CircularProgressIndicator(
                              strokeWidth: SizeConfig.screenWidth! * 0.008,
                              strokeAlign: SizeConfig.screenWidth! * 0.003,
                            ),
                          ],
                        ],
                      )),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void closeLoadingDialog() {
    Navigator.of(Get.context!, rootNavigator: true).pop();
  }
}
