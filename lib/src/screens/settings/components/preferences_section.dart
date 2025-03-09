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
              activeTrackColor: AppColors.darkMainColor,
              activeColor: AppColors.mainColor,
              inactiveTrackColor: AppColors.lightenMainColor,
              inactiveThumbColor: Colors.white,
              value: settingsController.isDarkMode.value,
              // Dark Mode toggle Button Function
              onChanged: (val) {
                settingsController.toggleDarkMode(val);
                if (val) {
                  Get.changeTheme(darkAppTheme);
                } else {
                  Get.changeTheme(appTheme);
                }
              },
            ),
          ),
        ),
        SettingsTile(
          icon: Icons.notifications,
          title: S.of(context).notification,
          trailing: Switch(
            activeTrackColor: AppColors.darkMainColor,
            activeColor: AppColors.mainColor,
            inactiveTrackColor: AppColors.lightenMainColor,
            inactiveThumbColor: Colors.white,
            value: false,
            onChanged: (val) {},
          ),
        ),
        SettingsTile(
          icon: Icons.language,
          title: S.of(context).language,
          trailing: const Icon(
            Icons.arrow_forward_ios,
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
