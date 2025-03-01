import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../config/images.dart';
import '../../../config/themes.dart';
import '../../../controller/exam_controller.dart';

class AIBottomSheet extends StatelessWidget {
  AIBottomSheet({
    super.key,
  });

  final ExamController controller = Get.find<ExamController>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (_, scrollController) =>
          Container(
              decoration: const BoxDecoration(
                color: AppColors.moreLightenMainColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                if (controller.isGeneratingResponse.value) {
              return Center(
                child: AspectRatio(
                  aspectRatio: 1, // 1:1 ratio (square), adjust as needed
                  child: Lottie.asset(Images.thinkingAnimation),
                ),
              );
            }
            return Column(
                  children: [
                    Container(
                      width: 150, // Width of the line
                      height: 5, // Height (thickness) of the line
                      color: AppColors.lightenMainColor, // Color of the line
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset(
                          Images.falih,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      controller.generatedResponse.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                );
              })),
    );
  }
}
