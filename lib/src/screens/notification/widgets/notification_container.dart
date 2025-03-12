import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
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
            radius: 35,
            child: Image.asset(
              Images.logoFalih,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: SizeConfig.screenWidth! * 0.020,
          ),
          // content of the box
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                // Time and Date
                SizedBox(height: SizeConfig.screenHeight! * 0.005),
                Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: SizeConfig.screenHeight! * 0.010),
                Text(date),
              ],
            ),
          ),
          IconButton(
            onPressed: deleteNotification,
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: SizeConfig.screenWidth! * 0.07,
            ),
          )
        ],
      ),
    );
  }
}
