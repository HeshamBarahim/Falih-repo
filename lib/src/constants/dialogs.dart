import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../config/themes.dart';
import '../screens/run_exam/widgets_run_exam/result_dialog.dart';

showErrorMessage(message) {
  Get.snackbar(S.current.error, message, backgroundColor: AppColors.errorColor);
}

showSuccessMessage({title = "Success",
  required message,
  backgroundColor = AppColors.moreLightenMainColor,
  colorText = AppColors.successColor,
  snackPosition = SnackPosition.TOP}) {
  Get.snackbar(title, message,
      backgroundColor: backgroundColor,
      colorText: colorText,
      snackPosition: snackPosition);
}

showWarningMessage(message) {
  Get.snackbar("Warning", message, backgroundColor: AppColors.warningColor);
}

showInfoMessage({title = "Info",
  required message,
  backgroundColor = AppColors.moreLightenMainColor,
  colorText = AppColors.mainColor}) {
  Get.snackbar(title, message,
      backgroundColor: backgroundColor, colorText: AppColors.mainColor);
}

showExamResult(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => ResultDialog(
      context: context,
    ),
  );
}