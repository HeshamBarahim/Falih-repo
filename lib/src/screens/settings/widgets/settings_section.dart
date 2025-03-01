import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

import '../../../config/themes.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsSection({
    super.key,
    required this.title,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: const BoxDecoration(
            color: AppColors.hintColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.002),
        Column(children: tiles),
      ],
    );
  }
}
