import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "By clicking on Create Account, you're agreeing the app",
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.screenWidth! * 0.03,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => {},
                child: Text(
                  'Terms of services',
                  style: TextStyle(
                    color: AppColors.successColor,
                    fontSize: SizeConfig.screenWidth! * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextSpan(
              text: ' and ',
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.screenWidth! * 0.03,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => {},
                child: Text(
                  ' Privacy Policy ',
                  style: TextStyle(
                    color: AppColors.successColor,
                    fontSize: SizeConfig.screenWidth! * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
