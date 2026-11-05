import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/dialogs.dart';
import '../../../controller/account_deletion_controller.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../md_dialogs/md_dialogs.dart';
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
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed("profile");
              },
            ),

            /// Privacy
            SettingsTile(
              icon: Icons.privacy_tip,
              title: S.of(context).privacy,
              trailing: const Icon(Icons.arrow_forward_ios),
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
              trailing: const Icon(Icons.arrow_forward_ios),
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
              trailing: const Icon(Icons.arrow_forward_ios),
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
              trailing: const Icon(Icons.arrow_forward_ios),
              // Logout Function
              onTap: () {
                AuthenticationRepository.instance.logout();
              },
            ),

            /// Delete account (required by Apple and Google Play)
            SettingsTile(
              icon: Icons.delete_forever,
              title: S.of(context).delete_account,
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _confirmDeletion(context),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _confirmDeletion(BuildContext context) async {
    final controller = Get.put(AccountDeletionController());
    final passwordField = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(ctx).delete_account),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(ctx).delete_account_warning),
            const SizedBox(height: 12),
            TextField(
              controller: passwordField,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: S.of(ctx).delete_account_confirm_password),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(S.of(ctx).cancel)),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(S.of(ctx).delete_account,
                  style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
    final password = passwordField.text;
    passwordField.dispose();
    if (confirmed != true) return;

    switch (await controller.deleteAccount(password)) {
      case DeleteAccountResult.success:
        Get.offAllNamed("login");
        showSuccessMessage(message: S.current.account_deleted);
      case DeleteAccountResult.wrongPassword:
        showErrorMessage(S.current.wrong_credentials);
      case DeleteAccountResult.failed:
        showErrorMessage(S.current.unexpected_error_occured);
    }
  }
}
