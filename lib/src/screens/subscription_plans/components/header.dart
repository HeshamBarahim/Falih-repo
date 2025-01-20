import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        // Header Text
        Text(
          S.of(context).get_premium,
          style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.058,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFBF7FC),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.012),
        Text(
          "${S.of(context).unlock_of_the_power} ${S.of(context).enjoy_digital_experience}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.039,
            color: const Color(0xFFBBA3C2),
          ),
        ),

        SizedBox(height: SizeConfig.screenHeight! * 0.02),

        // Box with image and plans
        SizedBox(
          height: SizeConfig.screenHeight! * 0.145,
          child: Center(
            child: Image.asset(
              'assets/images/premium_icon.png',
            ),
          ),
        ),
      ],
    );
  }
}
