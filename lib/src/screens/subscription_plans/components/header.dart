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
          "Get Premium",
          style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.058,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFBF7FC),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.012),
        Text(
          "Unlock all the power of this mobile tool and\n"
          "enjoy digital experience like never before!",
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
