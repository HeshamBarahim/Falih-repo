import 'package:device_preview/device_preview.dart';
import 'package:falih/src/controller/settings_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'src/app.dart';
// import 'src/controller/network_controller.dart';
import 'src/controller/network_controller_real_time.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) {});
  await initDependencies();
  // Initialize GetStorage
  await GetStorage.init();
  // Clear the cache
  // Get.put(NetworkController());
  Get.put(NetworkControllerRealTime());

  runApp(const MyApp());

  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(),
  //   ),
  // );
}

Future<void> initDependencies() async {
  Get.put(AuthenticationRepository());
  Get.put(UserRepository());
  Get.put(UserController());
  Get.put(SettingsController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}
