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
        const TextSpan(
            text: "By clicking on Create Account, you're agreeing the app",
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400)),
        WidgetSpan(
          child: GestureDetector(
            onTap: () => {},
            child: const Text(
              'Terms of services',
              style: TextStyle(
                  color: AppColors.successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const TextSpan(
            text: ' and ',
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400)),
        WidgetSpan(
          child: GestureDetector(
            onTap: () => {},
            child: const Text(
              ' Privacy Policy ',
              style: TextStyle(
                  color: AppColors.successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ])),
    );
  }
}
