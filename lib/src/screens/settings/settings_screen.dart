import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/md_dialogs/md_dialogs.dart';
import 'package:falih/src/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/accounts_section.dart';
import 'components/preferences_section.dart';
import 'components/profile_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String sc_route = '/settings-screen-2';

  @override
  Widget build(BuildContext context) {
    final closeButton = S.of(context).close;
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          S.of(context).settings,
          style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.059,
            color: fontColor_1,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: SizeConfig.screenWidth! * 0.078,
            color: iconColor_1,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.04,
            vertical: SizeConfig.screenHeight! * 0.026),
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: secondaryBackgroundColor_2,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Section
              SizedBox(height: SizeConfig.screenHeight! * 0.095),
              ProfileSection(),
              SizedBox(height: SizeConfig.screenHeight! * 0.026),

              /// Preferences Section
              PreferencesSection(
                // Dark Mode toggle Button Function
                // Toggle the theme using the controller

                onChangeDarkModeFunction: (val) {},
                // Notifications toggle Button Function
                onChangeNotificationsFunction: (val) {},
                // Language Button Function
                onTapLanguageFunction: () {},
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.004),

              /// Account Section
              AccountSection(
                // About Button Function
                onTapEditProfileFunction: () {
                  Get.to(() => EditProfileScreen());
                },
                // Privacy Button Function
                onTapPrivacyFunction: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MdDialogs(
                          mdFileName: 'privacy_policy.md',
                          buttonText: closeButton,
                        );
                      });
                },
                // Terms & Conditions Button Function
                onTapTerms_ConditionsFunction: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MdDialogs(
                          mdFileName: 'terms_conditions.md',
                          buttonText: closeButton,
                        );
                      });
                },

                /// Logout Button
                onTapLogoutFunction: () {
                  AuthenticationRepository.instance.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
