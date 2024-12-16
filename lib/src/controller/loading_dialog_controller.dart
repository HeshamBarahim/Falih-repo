import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialogController extends GetxController {
  final RxBool _isShowing = false.obs;

  Future<void> showLoadingDialog(
      BuildContext context, VoidCallback performFunction) async {
    // Simulate a delay to mimic a long-running operation
    await Future.delayed(Duration(seconds: 0));
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        // Trigger the function when the dialog appears
        performFunction();
        Get.back();
        return AlertDialog(
          title: Text('Processing...'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Please wait"),
            ],
          ),
        );
      },
    );
    // Once the function is complete, close the dialog
  }

  // void showDialogWithFunction(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible:
  //         false, // Prevents dismissing the dialog by tapping outside
  //     builder: (BuildContext context) {
  //       // Trigger the function when the dialog appears
  //       showLoadingDialog(context);

  //       return AlertDialog(
  //         title: Text('Processing...'),
  //         content: Row(
  //           children: [
  //             CircularProgressIndicator(),
  //             SizedBox(width: 20),
  //             Text("Please wait"),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
