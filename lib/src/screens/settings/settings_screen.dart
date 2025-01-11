import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/repository/authentication_repository/authentication_repository.dart';
import 'package:falih/src/screens/md_dialogs/md_dialogs.dart';
import 'package:falih/src/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main_screen/main_screen.dart';
import 'components/accounts_section.dart';
import 'components/preferences_section.dart';
import 'components/profile_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String scRoute = '/settings-screen-2';

  @override
  Widget build(BuildContext context) {
    final closeButton = S.of(context).close;
    //  Current language code
    final locale = Localizations.localeOf(context).languageCode;
    // Check if the language is Arabic
    final isArabic = locale == 'ar';
    // Choose the file based on the language
    final privacyFile =
        isArabic ? 'privacy_policy_ar.md' : 'privacy_policy_en.md';
    final termsFile =
        isArabic ? 'terms_conditions_ar.md' : 'terms_conditions_en.md';
    final rulesFile = isArabic ? 'rules_prizes_ar.md' : 'rules_prizes_en.md';
    SizeConfig().init(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Navigate to the menu screen when the user tries to pop
          Get.offAll(MainScreen());
        }
      },
      child: Scaffold(
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
              Get.offAll(MainScreen());
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
                            mdFileName: privacyFile,
                            buttonText: closeButton,
                          );
                        });
                  },
                  // Terms & Conditions Button Function
                  onTapTermsConditionsFunction: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MdDialogs(
                            mdFileName: termsFile,
                            buttonText: closeButton,
                          );
                        });
                  },
                  // Rules & Prizes Button Function
                  onRulesAndPrizes: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MdDialogs(
                            mdFileName: rulesFile,
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
      ),
    );
  }
}
