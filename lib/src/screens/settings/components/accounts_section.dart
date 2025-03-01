import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../md_dialogs/md_dialogs.dart';
import '../../profile/edit_profile_screen.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final isArabic = Get.locale?.languageCode == 'ar';
    final privacyFile =
        isArabic ? 'privacy_policy_ar.md' : 'privacy_policy_en.md';
    final termsFile =
        isArabic ? 'terms_conditions_ar.md' : 'terms_conditions_en.md';
    final rulesFile = isArabic ? 'rules_prizes_ar.md' : 'rules_prizes_en.md';

    return Column(
      children: [
        /// Account Section
        SettingsSection(
          title: S.of(context).account,
          tiles: [
            /// Edit profile
            SettingsTile(
              icon: Icons.person,
              title: S.of(context).edit_profile,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: AppColors.secondaryColor,
              ),
              onTap: () {
                Get.to(() => EditProfileScreen());
              },
            ),

            /// Privacy
            SettingsTile(
              icon: Icons.privacy_tip,
              title: S.of(context).privacy,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: AppColors.secondaryColor,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MdDialogs(mdFileName: privacyFile);
                    });
              },
            ),

            /// Terms & Conditions
            SettingsTile(
              icon: Icons.info,
              title: S.of(context).terms_conditions,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: AppColors.secondaryColor,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MdDialogs(mdFileName: termsFile);
                    });
              },
            ),

            /// Rules && Prizes
            SettingsTile(
              icon: Icons.view_list_rounded,
              title: S.of(context).rules_prizes,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: AppColors.secondaryColor,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MdDialogs(mdFileName: rulesFile);
                    });
              },
            ),

            /// Logout Button
            SettingsTile(
              icon: Icons.logout,
              title: S.of(context).logout,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.screenWidth! * 0.063,
                color: AppColors.secondaryColor,
              ),
              // Logout Function
              onTap: () {
                AuthenticationRepository.instance.logout();
              },
            ),
          ],
        ),
      ],
    );
  }
}
