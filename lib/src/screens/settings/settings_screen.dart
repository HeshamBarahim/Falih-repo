import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/controller/settings_controller.dart';
import 'package:falih/src/controller/user_controller.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/accounts_section.dart';
import 'components/preferences_section.dart';
import 'components/profile_section.dart';

class SettingsScreen extends StatelessWidget {
  static const String sc_route = '/settings-screen-2';

  SettingsScreen({Key? key}) : super(key: key);
  final UserController userController = Get.find<UserController>();
  final SettingsController settingsController = Get.find<SettingsController>();

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
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.04),
        decoration: const BoxDecoration(
          gradient: secondaryBackgroundColor_2,
        ),
        child: Column(
          children: [
            // Profile Section
            SizedBox(height: SizeConfig.screenHeight! * 0.095),
            ProfileSection(
                // profileImage: userController.profileImageUrl.value,
                name: userController.user.value!.fullName,
                email: userController.user.value!.phoneNo),
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
              onTapPrivacyFunction: () {},
              // Terms & Conditions Button Function
              onTapTerms_ConditionsFunction: () {},

              /// Logout Button
              onTapLogoutFunction: () {
                AuthenticationRepository.instance.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
