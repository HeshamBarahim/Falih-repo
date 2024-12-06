import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../config/sizes.dart';

import '../models/rive_asset.dart';

class NavBarTile extends StatelessWidget {
  const NavBarTile({
    Key? key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  }) : super(key: key);

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.06),
          child: Divider(
            color: Colors.white24,
            height: SizeConfig.screenHeight! * 0.001,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: SizeConfig.screenHeight! * 0.066,
              width: isActive ? SizeConfig.screenWidth! * 0.7 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.screenHeight! * 0.012),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: SizeConfig.screenHeight! * 0.04,
                width: SizeConfig.screenHeight! * 0.04,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveonInit,
                ),
              ),
              title: Text(
                menu.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenHeight! * 0.018,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
