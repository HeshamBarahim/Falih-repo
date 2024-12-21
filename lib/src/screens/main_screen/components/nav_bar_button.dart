import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../config/sizes.dart';

class NavBarButton extends StatelessWidget {
  NavBarButton({
    Key? key,
    required this.press,
    required this.riveOnInit,
  }) : super(key: key);

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.04),
          height: SizeConfig.screenHeight! * 0.05,
          width: SizeConfig.screenHeight! * 0.05,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, SizeConfig.screenHeight! * 0.005),
                blurRadius: SizeConfig.screenHeight! * 0.01,
              ),
            ],
          ),
          child: RiveAnimation.asset(
            "assets/RiveAssets/menu_button.riv",
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
