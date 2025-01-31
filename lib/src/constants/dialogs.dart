import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../config/themes.dart';

showErrorMessage(message) {
  Get.snackbar(S.current.error, message, backgroundColor: AppColors.errorColor);
}

showSuccessMessage(
    {title = "Success",
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

showInfoMessage(
    {title = "Info",
    required message,
    backgroundColor = AppColors.moreLightenMainColor,
    colorText = AppColors.mainColor}) {
  Get.snackbar(title, message,
      backgroundColor: backgroundColor, colorText: AppColors.mainColor);
}
