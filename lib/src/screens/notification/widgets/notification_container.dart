import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({super.key});

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
            radius: SizeConfig.screenWidth! * 0.070,
            child: Image.asset(
              Images.test,
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
                    'New Journey to Falih',
                    style: TextStyle(
                        color: AppColors.bgScreen1,
                        fontSize: SizeConfig.screenWidth! * 0.050,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Time and Date
                SizedBox(height: SizeConfig.screenHeight! * 0.005),
                Row(
                  children: [
                    Text(
                      '22:13',
                      style: TextStyle(
                          color: AppColors.subHeaderNotTaken,
                          fontSize: SizeConfig.screenWidth! * 0.030),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('2024-12-07',
                        style: TextStyle(
                            color: AppColors.subHeaderNotTaken,
                            fontSize: SizeConfig.screenWidth! * 0.030))
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.005),
                // Content of the Box
                Text(
                    'Join us to have fun and get more fun ... lets start the journey',
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: SizeConfig.screenWidth! * 0.040)),
                SizedBox(height: SizeConfig.screenHeight! * 0.010),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'See More',
                      style: TextStyle(
                          color: AppColors.bgScreen1,
                          fontSize: SizeConfig.screenWidth! * 0.040),
                    ),
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
