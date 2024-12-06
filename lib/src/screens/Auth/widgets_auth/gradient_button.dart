import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onClick;

  const GradientButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: width == 0 ? SizeConfig.screenWidth! * 0.7 : width,
      height: height == 0 ? SizeConfig.screenHeight! * 0.06 : height,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(SizeConfig.screenHeight! * 0.035)),
        color: AppColors.mainColor,
      ),
      child: MaterialButton(
        height: SizeConfig.screenHeight! * 0.06,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.screenHeight! * 0.035)),
        textColor: Colors.white,
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.screenHeight! * 0.03,
          ),
        ),
      ),
    );
  }
}
