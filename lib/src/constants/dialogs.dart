import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../config/themes.dart';
import '../screens/run_exam/widgets_run_exam/result_dialog.dart';

showErrorMessage(message) {
  Get.snackbar(
    S.current.error,
    message,
    backgroundColor: AppColors.errorColor,
    colorText: Colors.white,
    dismissDirection: DismissDirection.horizontal,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 4),
    // icon: const Icon(Icons.done, color: Colors.white),
  );
}

showSuccessMessage({
  title = "Success",
  required message,
  backgroundColor = AppColors.moreLightenMainColor,
  colorText = AppColors.successColor,
  snackPosition = SnackPosition.TOP,
}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    colorText: colorText,
    snackPosition: snackPosition,
    dismissDirection: DismissDirection.horizontal,
    duration: const Duration(seconds: 4),
  );
}

showWarningMessage(message) {
  Get.snackbar(
    "Warning",
    message,
    backgroundColor: AppColors.warningColor,
    dismissDirection: DismissDirection.horizontal,
    snackPosition: SnackPosition.TOP,
  );
}

showInfoMessage(
    {title = "Info",
    required message,
    backgroundColor = AppColors.moreLightenMainColor,
    colorText = AppColors.mainColor}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    colorText: AppColors.mainColor,
    dismissDirection: DismissDirection.horizontal,
    snackPosition: SnackPosition.TOP,
  );
}

showExamResult(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => ResultDialog(
      context: context,
    ),
  );
}
