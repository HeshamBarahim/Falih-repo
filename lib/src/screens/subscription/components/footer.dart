import 'package:flutter/material.dart';


import 'package:falih/src/config/sizes.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      // Terms and Privacy
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "By placing this order, you agree to the ",
              style: TextStyle(
                color: Color(0xFFFBF7FC),
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text: "Terms of Service",
              style: TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text: " and ",
              style: TextStyle(
                color: Color(0xFFFBF7FC),
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text: "Privacy Policy.",
              style: TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
            TextSpan(
              text:
                  " Subscription automatically renews\nunless auto-renew is turned off at least 24-hours before\n"
                  "the end of the current period.",
              style: TextStyle(
                color: Color(0xFFFBF7FC),
                fontSize: SizeConfig.screenWidth! * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
