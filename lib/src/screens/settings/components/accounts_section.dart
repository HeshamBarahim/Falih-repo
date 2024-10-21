import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class AccountSection extends StatelessWidget {
  final VoidCallback onTapAboutFunction;
  final VoidCallback onTapPrivacyFunction;
  final VoidCallback onTapTerms_ConditionsFunction;
  final VoidCallback onTapLogoutFunction;

  const AccountSection(
      {super.key,
      required this.onTapAboutFunction,
      required this.onTapPrivacyFunction,
      required this.onTapTerms_ConditionsFunction,
      required this.onTapLogoutFunction});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        /// Account Section
        SettingsSection(
          title: 'Account',
          tiles: [
            SettingsTile(
              icon: Icons.info,
              title: 'About',
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: iconColor_1,
              ),
              // About Button Function
              onTap: onTapAboutFunction,
            ),
            SettingsTile(
              icon: Icons.privacy_tip,
              title: 'Privacy',
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: iconColor_1,
              ),
              // Privacy Button Function
              onTap: onTapPrivacyFunction,
            ),
            SettingsTile(
              icon: Icons.article,
              title: 'Terms & Conditions',
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: iconColor_1,
              ),
              // Terms & Conditions Button Function
              onTap: onTapTerms_ConditionsFunction,
            ),
          ],
        ),

        SizedBox(height: SizeConfig.screenHeight! * 0.024),

        /// Logout Button
        SettingsTile(
          icon: Icons.logout,
          title: 'Logout',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.screenWidth! * 0.063,
            color: iconColor_1,
          ),
          // Logout Function
          onTap: onTapLogoutFunction,
        ),
      ],
    );
  }
}
