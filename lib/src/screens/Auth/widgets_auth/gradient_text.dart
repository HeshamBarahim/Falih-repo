import 'package:flutter/material.dart';
import 'package:falih/src/config/themes.dart';

class GradientText extends StatelessWidget {
  final String text;
  // final Function route;
  const GradientText({
    super.key,
    required this.text,
    // required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          AppColors.primaryGradients.createShader(bounds),
      child: InkWell(
        // onTap: route(),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
