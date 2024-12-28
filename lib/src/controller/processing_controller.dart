import 'package:get/get.dart';

class ProcessController extends GetxController {
  RxBool isProcessing = false.obs;

  Future<void> startProcess(var function) async {
    if (!isProcessing.value) {
      isProcessing.value = true;
      try {
        function;
        isProcessing.value = true;
      } catch (e) {
        print('Error: $e');
        isProcessing.value = false;
      }
    }
  }
}
