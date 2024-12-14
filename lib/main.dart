import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'src/app.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) {
    Get.put(AuthenticationRepository());
    Get.put(UserRepository());
    Get.put(UserController()); // Initialize UserController
  });

  // Initialize GetStorage
  await GetStorage.init();
  // Clear the cache

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: App(),
          );
        });
  }
}
