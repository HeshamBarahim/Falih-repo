import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      // Terms and Privacy
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: S.of(context).by_placing_this,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text: S.of(context).terms_conditions,
              style: TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text: S.of(context).and,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text: S.of(context).privacy_policy,
              style: TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text: S.of(context).subscription_automatically_renews,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
