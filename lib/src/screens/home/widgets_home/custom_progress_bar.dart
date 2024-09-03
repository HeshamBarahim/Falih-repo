import 'package:flutter/material.dart';
import 'package:falih/src/config/themes.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.width,
    required this.height,
    required this.progress,
  });
  final double width;
  final double height;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderColor, width: 1.0),
          ),
          child: Stack(
            children: [
              Container(
                width: width * progress,
                height: height,
                decoration: BoxDecoration(
                    gradient: AppColors.primaryGradients,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            '${(progress * 100).toInt()}%',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
