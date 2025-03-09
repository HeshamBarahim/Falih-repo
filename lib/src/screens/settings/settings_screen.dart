import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
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
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          S.of(context).settings,
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
    );
  }
}
