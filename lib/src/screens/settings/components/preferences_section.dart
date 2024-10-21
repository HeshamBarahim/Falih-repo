import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class PreferencesSection extends StatelessWidget {
  final bool? Function(bool?) onChangeDarkModeFunction;
  final bool? Function(bool?) onChangeNotificationsFunction;
  final VoidCallback onTapLanguageFunction;

  const PreferencesSection(
      {super.key,
      required this.onChangeDarkModeFunction,
      required this.onChangeNotificationsFunction,
      required this.onTapLanguageFunction});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SettingsSection(
      title: 'Preferences',
      tiles: [
        SettingsTile(
          icon: Icons.dark_mode,
          title: 'Dark Mode',
          trailing: Switch(
            activeTrackColor: iconColor_2,
            activeColor: Colors.white,
            inactiveTrackColor: Color(0xFFBBA3C2),
            inactiveThumbColor: Colors.white,
            // inactiveTrackColor: Colors.grey,
            value: true,
            // Dark Mode toggle Button Function
            onChanged: onChangeDarkModeFunction,
          ),
        ),
        SettingsTile(
          icon: Icons.notifications,
          title: 'Notifications',
          trailing: Switch(
            activeTrackColor: iconColor_2,
            activeColor: Colors.white,
            inactiveTrackColor: Color(0xFFBBA3C2),
            inactiveThumbColor: Colors.white,
            value: false,
            // Notifications toggle Button Function
            onChanged: onChangeNotificationsFunction,
          ),
        ),
        SettingsTile(
          icon: Icons.language,
          title: 'Language',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.screenWidth! * 0.063,
            color: iconColor_1,
          ),
          // Language Button Function
          onTap: onTapLanguageFunction,
        ),
      ],
    );
  }
}
