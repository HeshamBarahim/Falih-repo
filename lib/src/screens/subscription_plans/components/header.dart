import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/images.dart';
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
        Text(
          S.of(context).get_premium,
            style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: SizeConfig.screenHeight! * 0.012),
        Text(
          "${S.of(context).unlock_of_the_power} ${S.of(context).enjoy_digital_experience}",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: SizeConfig.screenHeight! * 0.12,
          child: Center(
            child: Image.asset(Images.subscriptionImage),
          ),
        ),
      ],
    );
  }
}
