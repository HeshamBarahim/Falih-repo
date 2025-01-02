import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class UserPointsProgressBar extends StatelessWidget {
  const UserPointsProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: LinearProgressIndicator(
            value: 0.1, // Bind progress value
            backgroundColor: AppColors.mainColor,
            color: AppColors.secondaryColor,
            minHeight: 10,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            '${(0.1 * 100).toInt()}%',
            style: const TextStyle(
                color: AppColors.secondaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
