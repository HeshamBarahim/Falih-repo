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
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.mainColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
