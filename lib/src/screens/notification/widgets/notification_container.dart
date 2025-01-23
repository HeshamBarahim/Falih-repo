import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../../../controller/notifications_controller.dart';

class NotificationContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String date;
  final VoidCallback deleteNotification;

  const NotificationContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.deleteNotification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        borderRadius: BorderRadius.circular(8), // Rounded corners
        border: Border.all(
          color: Colors.grey.shade300, // Border color
          width: 2, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            blurRadius: 4, // Softness of the shadow
            spreadRadius: 1, // How far the shadow spreads
            offset: const Offset(2, 2), // Position of the shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // image part
          CircleAvatar(
            radius: SizeConfig.screenWidth! * 0.090,
            child: Image.asset(
              Images.logoFalih,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: SizeConfig.screenWidth! * 0.010,
          ),
          // content of the box
          Expanded(
            child: Column(
              children: [
                // Title
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: AppColors.bgScreen1,
                        fontSize: SizeConfig.screenWidth! * 0.050,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Time and Date
                SizedBox(height: SizeConfig.screenHeight! * 0.005),
                Text(date),
                SizedBox(height: SizeConfig.screenHeight! * 0.005),
                // Content of the Box
                Text(subTitle,
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: SizeConfig.screenWidth! * 0.040)),
                SizedBox(height: SizeConfig.screenHeight! * 0.010),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    IconButton(
                      onPressed: deleteNotification,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: SizeConfig.screenWidth! * 0.07,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
