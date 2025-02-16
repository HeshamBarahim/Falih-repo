import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight! * 0.02),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.mainColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            S.current.resend_code,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.darkMainColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
