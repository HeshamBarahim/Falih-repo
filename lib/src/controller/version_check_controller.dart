import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../generated/l10n.dart';
import 'loading_dialog_controller.dart';

class VersionCheckController extends GetxController {
  final LoadingDialogController loadingDialogController =
      LoadingDialogController();

  @override
  void onInit() {
    // TODO: implement onInit
    checkVersion();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _showSnackbar(title: 'title', message: 'message', color: Colors.black, icon: Icons.abc);
  }

  // Show a snackbar with custom message
  void _showSnackbar(
      {required String title,
      required String message,
      required Color color,
      required IconData icon}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
      icon: Icon(icon, color: Colors.white),
    );
  }

  Future<bool> checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionName = packageInfo.version; // Version Name
    String versionCode = packageInfo.buildNumber; // Version Code

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('app_config').get();
    if (versionCode != querySnapshot.docs.first['VersionCode'] ||
        versionName != querySnapshot.docs.first['VersionName']) {
      return true;
    } else {
      return false;
    }
  }

  void showUpdateDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible:
          false, // لا يمكن للمستخدم إغلاق الـ Dialog بالضغط خارجها
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'تحديث جديد متاح',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content:
            Text('هناك تحديث جديد للتطبيق، قم بتحديث التطبيق أولًا لاستخدامه.'),
        actions: [
          TextButton(
            onPressed: () => _launchURL(),
            child: Text(
              'تحديث',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          TextButton(
            onPressed: () => _exitApp(),
            child: Text(
              S.current.exit,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL() {}

  void _exitApp() {
    exit(0);
  }
}
