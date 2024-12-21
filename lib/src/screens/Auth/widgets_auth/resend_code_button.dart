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
        height: SizeConfig.screenHeight! * 0.06,
        width: SizeConfig.screenWidth! * 0.5,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.mainColor),
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.1),
        ),
        child: Center(
          child: Text(
            S.of(context).resend_code,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.screenWidth! * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
