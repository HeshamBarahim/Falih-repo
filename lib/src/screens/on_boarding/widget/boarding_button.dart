import 'package:falih/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class BoardingButton extends StatelessWidget {
  const BoardingButton({super.key, required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth! * 0.6,
      height: SizeConfig.screenHeight! * 0.07,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: SizeConfig.screenWidth! * 0.007),
        borderRadius: BorderRadius.all(Radius.circular(SizeConfig.screenWidth! * 0.03)),
        color: Colors.black.withOpacity(0.5),
      ),
      child: MaterialButton(
        height: SizeConfig.screenHeight! * 0.05,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.12),
        ),
        textColor: Colors.white,
        onPressed: onClick,
        child: Text(
          S.of(context).next,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.screenWidth! * 0.05,
          ),
        ),
      ),
    );
  }
}
