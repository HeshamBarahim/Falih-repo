import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class NetworkControllerRealTime extends GetxController {
  var isConnected = false.obs;

  // Track previous connection state to avoid duplicate snackbars
  bool previousConnectionState = false;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  // Initial check when app starts
  Future<void> checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    await _updateConnectionStatus(result);
  }

  // Update connection status and show snackbar
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result == ConnectivityResult.none) {
      isConnected.value = false;

      // Show snackbar if previously connected
      if (previousConnectionState) {
        Get.snackbar(
          S.current.no_internet_connection,
          S.current.u_are_disconnected_from_the_internet,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          dismissDirection: DismissDirection.horizontal,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.wifi_off, color: Colors.white),
        );
      }
    } else {
      try {
        // Check if we can actually access the internet
        final response = await InternetAddress.lookup('google.com');
        if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
          isConnected.value = true;

          // Show snackbar if previously disconnected
          if (!previousConnectionState) {
            Get.snackbar(
              S.current.connected_to_the_internet,
              S.current.u_are_now_connected_to_internet,
              backgroundColor: Colors.green.shade600,
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 4),
              icon: const Icon(Icons.wifi, color: Colors.white),
            );
          }
        } else {
          isConnected.value = false;
        }
      } catch (e) {
        isConnected.value = false;

        // Show snackbar if previously connected
        if (previousConnectionState) {
          Get.snackbar(
            S.current.no_internet_connection,
            S.current.u_are_disconnected_from_the_internet,
            backgroundColor: Colors.red.shade600,
            dismissDirection: DismissDirection.horizontal,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 4),
            icon: const Icon(Icons.wifi_off, color: Colors.white),
          );
        }
      }
    }

    // Update the previous connection state to reflect the current state
    previousConnectionState = isConnected.value;
  }
}
