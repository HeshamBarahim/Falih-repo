import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../config/themes.dart';

showErrorMessage(message) {
  Get.snackbar(S.current.error, message, backgroundColor: AppColors.errorColor);
}
