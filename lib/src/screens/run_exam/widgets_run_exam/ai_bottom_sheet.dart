import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/exam_controller.dart';

class AIBottomSheet extends StatelessWidget {
  AIBottomSheet({
    super.key,
  });

  final ExamController controller = Get.find<ExamController>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            if (controller.isGeneratingResponse.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              controller: scrollController,
              children: [
                Text(
                  controller.generatedResponse.value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            );
          })),
    );
  }
}
