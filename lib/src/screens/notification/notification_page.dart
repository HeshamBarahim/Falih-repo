import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: const AssetImage(
                Images.backgroundImageOfAuth,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                  BlendMode.lighten))),
      padding: const EdgeInsets.all(20),
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                S.of(context).notification,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .20,
              ),
              // box of notitication
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: const Border(
                          bottom:
                              BorderSide(color: AppColors.mainColor, width: 1),
                        ),
                      ),
                      child: Image.asset(Images.logoFalih),
                    ),
                    Column(
                      children: [
                        // Title of the notification
                        Text(
                          'Yes You can,, u are better',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10.sp),
                        ),
                        // the context of the notification
                        const Expanded(
                            child: Text(
                                'u should review every day to success and be great,,, greatness not come easily.... sooo')),
                        const Text('09:54,  29,oct,2024')
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
