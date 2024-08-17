import 'package:flutter/material.dart';
import 'package:falih/src/config/themes.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "By clicking on Create Account, you're agreeing the app",
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400)),
        WidgetSpan(
          child: GestureDetector(
            onTap: () => {},
            child: ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradients.createShader(bounds),
              child: Text(
                'Terms of services',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
        TextSpan(
            text: ' and ',
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400)),
        WidgetSpan(
          child: GestureDetector(
            onTap: () => {},
            child: ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradients.createShader(bounds),
              child: Text(
                ' Privacy Policy ',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
