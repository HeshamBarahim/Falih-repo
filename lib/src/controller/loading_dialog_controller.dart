import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialogController extends GetxController {
  // RxBool isLoading = false.obs;

  void openLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16.0),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void closeLoadingDialog(BuildContext context) {
    // isLoading.value = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

  // void openLoadingDialog() {
  //   // isLoading.value = true;
  // }

  //   Widget loadingDialog() {
  //   return isLoading.value
  //       ? Container(
  //           child: Center(
  //             child: Column(
  //               children: [
  //                 CircularProgressIndicator(),
  //                 Text(
  //                   'Loading...',
  //                   style: TextStyle(
  //                     fontSize: 20.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       : SizedBox();
  // }

  // Future<void> performFunction(BuildContext context) async {
  //   await Future.delayed(Duration(seconds: 3));

  //   Get.back();
  // }

  // void showDialogWithFunction(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
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
