import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  List<QueryDocumentSnapshot> notificationsList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getNotificationsList();
    getNotificationsPermission();
    foreGroundNotificationsHandler();
    backgroundNotificationsHandler();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> getNotificationsList() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .get();
    // await Future.delayed(Duration(seconds: 2));
    if (notificationsList.isNotEmpty) {
      notificationsList.clear();
      notificationsList.addAll(querySnapshot.docs);
    } else {
      notificationsList.addAll(querySnapshot.docs);
    }
    update();
  }

  Future<void> addNotification(
      String title, String subTitle, String date) async {
    final user = FirebaseAuth.instance.currentUser;

    getNotificationsList();

    CollectionReference notifications = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('notifications');

    if (notificationsList.isNotEmpty) {
      await notifications
          .add({
            'id': notificationsList.length + 1,
            'title': '${title}',
            'subTitle': '${subTitle}',
            'date': '${date}'
          })
          .then((value) => print("Note Added"))
          .catchError((error) {
            print("Failed To Add Note: $error");
          });
    } else {
      await notifications
          .add({
            'id': 1,
            'title': '${title}',
            'subTitle': '${subTitle}',
            'date': '${date}'
          })
          .then((value) => print("Note Added"))
          .catchError((error) {
            print("Failed To Add Note: $error");
          });
    }
    getNotificationsList();
  }

  Future<void> deleteNotification(String index) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('notifications')
        .doc(index)
        .delete();

    getNotificationsList();
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

  Future<void> foreGroundNotificationsHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground! ${message.data}');
      // print('---------------------------------------------------------------');
      // print('---------------------------------------------------------------');
      // print('Message data : ${message.data}');
      // print('Message data : ${message.notification!.title}');
      // print('Message data : ${message.notification!.body}');
      // print('Message data : ${message.sentTime}');
      // getNotificationsList();

      Get.snackbar(
        '${message.notification!.title}',
        // '${message.sentTime}',
        '${message.notification!.body}',
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Color(0xFFFFFFFF),
        colorText: Color(0xFF742e89),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.notifications, color: Color(0xFF742e89)),
      );
      addNotification(
        '${message.notification!.title}',
        '${message.notification!.body}',
        '${message.sentTime!.day}/${message.sentTime!.month}/${message.sentTime!.year} - ${message.sentTime!.hour.toString().padLeft(2, '0')}:${message.sentTime!.minute.toString().padLeft(2, '0')}',
      );
    });
  }

  Future<void> backgroundNotificationsHandler() async {
    // TODO: implement terminatedNotifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      addNotification(
        '${message.notification!.title}',
        '${message.notification!.body}',
        '${message.sentTime!.day}/${message.sentTime!.month}/${message.sentTime!.year} - ${message.sentTime!.hour.toString().padLeft(2, '0')}:${message.sentTime!.minute.toString().padLeft(2, '0')}',
      );
    });
  }
}
