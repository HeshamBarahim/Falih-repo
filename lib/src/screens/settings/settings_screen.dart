import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/accounts_section.dart';
import 'components/preferences_section.dart';
import 'components/profile_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String scRoute = '/settings-screen-2';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0), // Default AppBar height
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.choicesColor,
          ),
          child: AppBar(
            elevation: 0,
            // Remove shadow
            backgroundColor: Colors.transparent,
            title: Text(
              S.of(context).settings,
              style: const TextStyle(
                fontSize: 26,
                color: AppColors.mainColor,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 26,
                color: AppColors.mainColor,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.secondaryBackgroundColor_2,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.03),

              /// Profile Section
              ProfileSection(),
              SizedBox(height: SizeConfig.screenHeight! * 0.026),

              /// Preferences Section
              PreferencesSection(),

              /// Account Section
              const AccountSection(),
            ],
          ),
        ),
      ),
    );
  }
}
