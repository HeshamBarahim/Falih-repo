import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'components/accounts_section.dart';
import 'components/preferences_section.dart';
import 'components/profile_section.dart';
import 'widgets/settings_section.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen_2 extends StatelessWidget {
  static const String sc_route = '/settings-screen-2';
  const SettingsScreen_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions From Sizes Calss
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.046,
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.04),
        decoration: BoxDecoration(
          gradient: secondaryBackgroundColor_2,
        ),
        child: Column(
          children: [
            // Profile Section
            SizedBox(height: SizeConfig.screenHeight! * 0.095),
            ProfileSection(
                profileImage:
                    'https://www.esafety.gov.au/sites/default/files/2019-07/protect_your_personal_information_0.jpg',
                name: 'Yusif',
                email: 'yusif123@gmail.com'),
            SizedBox(height: SizeConfig.screenHeight! * 0.026),

            /// Preferences Section
            PreferencesSection(
              // Dark Mode toggle Button Function
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
              onTapAboutFunction: () {},
              // Privacy Button Function
              onTapPrivacyFunction: () {},
              // Terms & Conditions Button Function
              onTapTerms_ConditionsFunction: () {},

              /// Logout Button
              onTapLogoutFunction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
