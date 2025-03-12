import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/screens/notification/widgets/notification_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/notifications_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(S.of(context).notification,
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<NotificationsController>(
        init: NotificationsController(),
        builder: (controller) {
          return controller.notificationsList.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(25),
                  itemCount: controller.notificationsList.length,
                  itemBuilder: (context, index) {
                    return NotificationContainer(
                      title: controller.notificationsList[index]['title'],
                      subTitle: controller.notificationsList[index]['subTitle'],
                      date: controller.notificationsList[index]['date'],
                      deleteNotification: () {
                        controller.deleteNotification(
                            controller.notificationsList[index].id);
                      },
                    );
                  },
                )
              : Center(
                  child: Text(S.current.no_notification,
                      style: Theme.of(context).textTheme.titleMedium),
                );
        },
      ),
    );
  }
}
