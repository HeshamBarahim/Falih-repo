import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/notification/widgets/notification_container.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: const AssetImage(
                Images.backgroundImageOfAuth,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                BlendMode.lighten,
              ),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                S.of(context).notification,
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth! * 0.059,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: SizeConfig.screenWidth! * 0.078,
                  color: AppColors.mainColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: 6 + 1,
              itemBuilder: (context, index) {
                return const NotificationContainer(); // Notification items
              },
            ),
          )),
    ]);
  }
}
