import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class PreferencesSection extends StatelessWidget {
  PreferencesSection({super.key});

  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SettingsSection(
      title: S.of(context).preferences,
      tiles: [
        SettingsTile(
          icon: Icons.dark_mode,
          title: S.of(context).dark_mode,
          trailing: Obx(
            () => Switch(
              activeTrackColor: const Color(0xFFBBA3C2),
              activeColor: AppColors.mainColor,
              inactiveTrackColor: const Color(0xFFBBA3C2),
              inactiveThumbColor: Colors.white,
              value: settingsController.isDarkMode.value,
              // Dark Mode toggle Button Function
              onChanged: (val) {
                settingsController.toggleDarkMode(val);
                if (val) {
                  Get.changeTheme(ThemeData.dark());
                } else {
                  Get.changeTheme(ThemeData.light());
                }
              },
            ),
          ),
        ),
        SettingsTile(
          icon: Icons.notifications,
          title: S.of(context).notification,
          trailing: Switch(
            activeTrackColor: AppColors.mainColor,
            activeColor: Colors.white,
            inactiveTrackColor: const Color(0xFFBBA3C2),
            inactiveThumbColor: Colors.white,
            value: false,
            onChanged: (val) {},
          ),
        ),
        SettingsTile(
          icon: Icons.language,
          title: S.of(context).language,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.screenWidth! * 0.063,
            color: AppColors.secondaryColor,
          ),
          // Language Button Function
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('English'),
                          onTap: () {
                            settingsController.updateLanguage('en');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('العربية'),
                          onTap: () {
                            settingsController.updateLanguage('ar');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ],
    );
  }
}
