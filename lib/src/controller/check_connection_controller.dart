import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CheckConnectionController extends GetxController {
  // var isConnected = await checkInternetConnection();
  ///////////////////////////////////////////////////////////////////
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true; // Connected to either mobile data or Wi-Fi
    } else {
      return false; // No internet connection
    }
  }
  ///////////////////////////////////////////////////////////////////
}
