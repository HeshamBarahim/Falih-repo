import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../md_dialogs/md_dialogs.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';

    return Center(
      // Terms and Privacy
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: S.of(context).by_placing_this,
              style: const TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: S.of(context).terms_conditions,
              style: const TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  final termsFile = isArabic
                      ? 'terms_conditions_ar.md'
                      : 'terms_conditions_en.md';
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MdDialogs(mdFileName: termsFile);
                      });
                },
            ),
            TextSpan(
              text: S.of(context).and,
              style: const TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: S.of(context).privacy_policy,
              style: const TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  final privacyFile = isArabic
                      ? 'privacy_policy_ar.md'
                      : 'privacy_policy_en.md';
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MdDialogs(mdFileName: privacyFile);
                      });
                },
            ),
            TextSpan(
              text: S.of(context).subscription_automatically_renews,
              style: const TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
