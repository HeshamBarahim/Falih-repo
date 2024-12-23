import 'package:flutter/material.dart';

import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsSection({
    Key? key,
    required this.title,
    required this.tiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: SizeConfig.screenHeight! * 0.0355,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.0195,
            vertical: SizeConfig.screenHeight! * 0.00237,
          ),
          decoration: BoxDecoration(
            color: labelsColor,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: SizeConfig.screenWidth! * 0.04375,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.002),
        Column(children: tiles),
      ],
    );
  }
}
