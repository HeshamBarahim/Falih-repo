import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  Future<bool> checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    await _updateConnectionStatus(result);
    return isConnected.value;
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    if (results.isNotEmpty) {
      ConnectivityResult result = results.first;

      if (result != ConnectivityResult.none) {
        try {
          final response = await InternetAddress.lookup('google.com');
          if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
            isConnected.value = true;
          } else {
            isConnected.value = false;
          }
        } catch (e) {
          isConnected.value = false;
        }
      } else {
        isConnected.value = false;
      }
    }
  }
}
