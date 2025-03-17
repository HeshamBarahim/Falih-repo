import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';

class VersionCheckController extends GetxController {

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
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          S.current.new_update_available,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(S.current.new_update_available_text),
        actions: [
          TextButton(
            onPressed: () => _launchURL(),
            child: Text(
              S.current.update,
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

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(
        "https://play.google.com/store/apps/details?id=com.falih.app");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  void _exitApp() {
    exit(0);
  }
}
