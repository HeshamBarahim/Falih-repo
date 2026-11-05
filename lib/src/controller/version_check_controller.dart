import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../services/version_policy.dart';

class VersionCheckController extends GetxController {

  /// True when this install is older than the build required in `app_config`.
  /// Any failure (offline, missing config) lets the user in: a broken check
  /// must never lock people out. Only Android is gated; the update link is a
  /// Google Play link.
  Future<bool> checkVersion() async {
    if (!Platform.isAndroid) return false;
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final snapshot =
          await FirebaseFirestore.instance.collection('app_config').get();
      return isUpdateRequired(
        installedBuild: packageInfo.buildNumber,
        requiredBuild: pickRequiredBuild(snapshot.docs.map((d) => d.data())),
      );
    } catch (_) {
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
    SystemNavigator.pop();
  }
}
