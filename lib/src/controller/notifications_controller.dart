import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  /////////////////////////////
  @override
  void onInit() {
    // TODO: implement onInit
    getNotificationsPermission();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> getNotificationsPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // Future<void> foreGroundNotifications() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground! ${message.data}');
  //     print('Message data : ${message.data}');

  //     if (message.notification != null) {
  //       print(message.notification!.title);
  //       print(message.notification!.body);
  //     }
  //   });
  // }

  Future<void> backgroundNotificationsHandler() async {
    // TODO: implement terminatedNotifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }
}
