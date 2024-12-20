// navbar_tile
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
    // Get screen height and width
    SizeConfig().init(context);
    return Column(
      children: [
        // Divider padding adjusted based on screen width
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.036),
          child: Divider(
            color: Colors.white24,
            height: SizeConfig.screenHeight! * 0.001,
          ),
        ),
        Stack(
          children: [
            // AnimatedPositioned widget for the active state indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: SizeConfig.screenHeight! *
                  0.072, // Adjusted height based on screen
              width: isActive
                  ? SizeConfig.screenWidth! * 0.7
                  : 0, // Adjust width dynamically
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA620),
                  borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.screenHeight! *
                        0.012), // Border radius adjusted
                  ),
                ),
              ),
            ),
            // ListTile with icon and title
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: SizeConfig.screenHeight! *
                    0.04, // Icon size adjusted based on screen height
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
                  fontSize: SizeConfig.screenHeight! *
                      0.018, // Font size adjusted based on screen height
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
