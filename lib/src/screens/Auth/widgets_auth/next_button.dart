import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class NextButton extends StatelessWidget {
  final void Function()? funtion;

  const NextButton({
    super.key,
    required this.funtion,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialButton(
      color: AppColors.mainColor,
      // height: 50.h,
      height: SizeConfig.screenHeight! * 0.06,
      // minWidth: SizeConfig.screenWidth! * 0.8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: funtion,
      child: Center(
        child: Text(
          S.of(context).next,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.screenWidth! * 0.0577,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
