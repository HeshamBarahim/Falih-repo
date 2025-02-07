import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/screens/md_dialogs/md_dialogs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAgreeingCheck extends StatelessWidget {
  const CustomAgreeingCheck(
      {super.key, required this.value, required this.onChange});

  final RxBool value;
  final void Function(bool?)? onChange;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';
    final privacyFile =
        isArabic ? 'privacy_policy_ar.md' : 'privacy_policy_en.md';
    final termsFile =
        isArabic ? 'terms_conditions_ar.md' : 'terms_conditions_en.md';
    return Row(
      children: [
        Obx(
          () => CheckboxTheme(
            data: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(4), // Optional: Add border radius
              ),
              side: const BorderSide(
                color: AppColors.hintColor, // Set your desired border color
                width: 2.0, // Set the border width
              ),
            ),
            child: Checkbox(
              value: value.value,
              onChanged: onChange,
            ),
          ),
        ),
        Expanded(
            child: RichText(
                text: TextSpan(
          text: S.of(context).agreeing_message,
          style: const TextStyle(
            color: AppColors.hintColor,
            height: 1.5,
            fontFamily: "ElMessiri",
          ),
          children: [
            TextSpan(
              text: S.of(context).terms_conditions,
              style: const TextStyle(
                  color: AppColors.warningColor, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => showDialog(
                    context: context,
                    builder: (context) {
                      return MdDialogs(mdFileName: termsFile);
                    }),
            ),
            TextSpan(
              text: S.of(context).and,
            ),
            TextSpan(
              text: S.of(context).privacy_policy,
              style: const TextStyle(
                  color: AppColors.warningColor, fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => showDialog(
                    context: context,
                    builder: (context) {
                      return MdDialogs(mdFileName: privacyFile);
                    }),
            ),
            const TextSpan(
              text: ".",
            ),
          ],
        )))
      ],
    );
  }
}
