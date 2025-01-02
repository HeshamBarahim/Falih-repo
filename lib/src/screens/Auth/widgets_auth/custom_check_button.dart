import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class CustomCheckButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onClick;
  final bool isChecked;

  const CustomCheckButton({
    super.key,
    required this.isChecked,
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
        color: isChecked ? AppColors.mainColor : Colors.grey,
      ),
      child: MaterialButton(
        height: SizeConfig.screenHeight! * 0.06,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.screenHeight! * 0.035)),
        textColor: Colors.white,
        onPressed: isChecked ? () => onClick() : null,
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
