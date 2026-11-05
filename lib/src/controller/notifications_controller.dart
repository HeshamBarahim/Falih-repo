import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/notification_message.dart';

class NotificationsController extends GetxController {
  List<QueryDocumentSnapshot> notificationsList = [];

  @override
  void onInit() {
    getNotificationsList();
    getNotificationsPermission();
    foreGroundNotificationsHandler();
    backgroundNotificationsHandler();
    super.onInit();
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

  /// Stores a push message in the signed-in user's history. Uses the message
  /// id as the document id, so the same message is never stored twice. Does
  /// nothing for data-only messages or when nobody is signed in.
  Future<void> storeMessage(RemoteMessage message) async {
    final user = FirebaseAuth.instance.currentUser;
    final item = notificationFromMessage(
      title: message.notification?.title,
      body: message.notification?.body,
      sentTime: message.sentTime,
      now: DateTime.now(),
    );
    if (user == null || item == null) return;

    final notifications = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('notifications');
    final doc = (message.messageId?.isNotEmpty ?? false)
        ? notifications.doc(message.messageId)
        : notifications.doc();
    try {
      await doc.set({
        'title': item.title,
        'subTitle': item.subTitle,
        'date': item.date,
      });
    } catch (e) {
      debugPrint('Could not store notification: $e');
      return;
    }
    await getNotificationsList();
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
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void foreGroundNotificationsHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final n = message.notification;
      if (n != null) {
        Get.snackbar(
          n.title ?? '',
          n.body ?? '',
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: const Color(0xFFFFFFFF),
          colorText: const Color(0xFF742e89),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.notifications, color: Color(0xFF742e89)),
        );
      }
      storeMessage(message);
    });
  }

  void backgroundNotificationsHandler() {
    // App opened by tapping a notification while it was in the background.
    FirebaseMessaging.onMessageOpenedApp.listen(storeMessage);
    // App opened by tapping a notification while it was terminated.
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) storeMessage(message);
    });
  }
}
