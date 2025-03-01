import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkControllerRealTime extends GetxController {
  var isConnected = false.obs;
  bool previousConnectionState = false;
  bool firstCheckDone = false; // Prevent showing snackbar on first launch

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  // Initial connection check when app starts
  Future<void> _checkInitialConnection() async {
    var result = await Connectivity().checkConnectivity();
    await _updateConnectionStatus(result, isInitialCheck: true);
  }

  // Update connection status
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result,
      {bool isInitialCheck = false}) async {
    if (result == ConnectivityResult.none) {
      _handleDisconnection();
    } else {
      await _handleConnection(isInitialCheck);
    }
  }

  // Handle when there is no internet connection
  void _handleDisconnection() {
    isConnected.value = false;
    if (previousConnectionState) {
      _showSnackbar(
        title: S.current.no_internet_connection,
        message: S.current.u_are_disconnected_from_the_internet,
        color: Colors.red.shade600,
        icon: Icons.wifi_off,
      );
    }
    previousConnectionState = false;
  }

  // Handle when internet is available
  Future<void> _handleConnection(bool isInitialCheck) async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        isConnected.value = true;

        // Only show snackbar if previously disconnected & not the first check
        if (!previousConnectionState && firstCheckDone) {
          _showSnackbar(
            title: S.current.connected_to_the_internet,
            message: S.current.u_are_now_connected_to_internet,
            color: Colors.green.shade600,
            icon: Icons.wifi,
          );
        }

        firstCheckDone = true;
        previousConnectionState = true;
      } else {
        _handleDisconnection();
      }
    } catch (e) {
      _handleDisconnection();
    }
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
}
