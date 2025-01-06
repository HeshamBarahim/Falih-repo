import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor_1,
        // size: screenHeight * 0.03,
        size: SizeConfig.screenWidth! * 0.062,
      ),
      title: Text(
        title,
        style: TextStyle(
          // fontSize: screenHeight * 0.021,
          fontSize: SizeConfig.screenWidth! * 0.043,
          color: fontColor_1,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
