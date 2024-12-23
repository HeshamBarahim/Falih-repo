import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class AccountSection extends StatelessWidget {
  final VoidCallback onTapEditProfileFunction;
  final VoidCallback onTapPrivacyFunction;
  final VoidCallback onTapTerms_ConditionsFunction;
  final VoidCallback onTapLogoutFunction;

  const AccountSection(
      {super.key,
      required this.onTapEditProfileFunction,
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
          title: S.of(context).account,
          tiles: [
            // Edit profile
            SettingsTile(
              icon: Icons.person,
              title: S.of(context).edit_profile,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: iconColor_1,
              ),
              onTap: onTapEditProfileFunction,
            ),
            // Privacy
            SettingsTile(
              icon: Icons.privacy_tip,
              title: S.of(context).privacy,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: iconColor_1,
              ),
              onTap: onTapPrivacyFunction,
            ),
            // Terms & Conditions
            SettingsTile(
              icon: Icons.info,
              title: S.of(context).terms_conditions,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: iconColor_1,
              ),
              onTap: onTapTerms_ConditionsFunction,
            ),
          ],
        ),

        SizedBox(height: SizeConfig.screenHeight! * 0.015),

        /// Logout Button
        SettingsTile(
          icon: Icons.logout,
          title: S.of(context).logout,
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
