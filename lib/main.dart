import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/settings_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/repository/user_repository/user_repository.dart';
import 'package:falih/src/screens/Auth/login/login.dart';
import 'package:falih/src/screens/main_screen/main_screen.dart';
import 'package:falih/src/screens/on_boarding/first_page_boarding.dart';
import 'package:falih/src/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'src/controller/network_controller_real_time.dart';
import 'src/controller/notifications_controller.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) {});
  await GetStorage.init();
  await initDependencies();
  runApp(const MyApp());
}

Future<void> initDependencies() async {
  Get.put(NotificationsController());
  Get.put(NetworkControllerRealTime());
  Get.put(AuthenticationRepository());
  Get.put(UserRepository());
  Get.put(UserController());
  Get.put(SettingsController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      locale: Get.find<SettingsController>().locale.value,
      fallbackLocale: const Locale('ar'),
      initialRoute: '/splash',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const FirstPageBoarding()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/main-screen', page: () => const MainScreen()),
      ],
    );
  }
}
