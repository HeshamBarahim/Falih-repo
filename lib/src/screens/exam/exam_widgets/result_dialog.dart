import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/leaderboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../controller/exam_controller.dart';
import '../../../controller/home_controller.dart';

class ResultDialog extends StatelessWidget {
  final BuildContext context;

  const ResultDialog({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final ExamController controller = Get.find<ExamController>();
    Get.find<LeaderboardController>(); // must already be registered, as before

    return Dialog(
      child: Builder(builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.shadowColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      controller.questions.length.toString(),
                      style: const TextStyle(
                        color: AppColors.shadowColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Correct Answers
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.successColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      controller.trueAnswers.value.toString(),
                      style: const TextStyle(
                        color: AppColors.successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10),
                  // Incorrect Answers
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      controller.falseAnswers.value.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Exam Time
              _responsiveContainer(
                context,
                icon: Icons.watch_later_outlined,
                label: controller.timeTaken.value.toString(),
                iconColor: AppColors.mainColor,
              ),

              const SizedBox(height: 10),

              // Score
              _responsiveContainer(
                context,
                label: "${controller.calculateUserPoints()} pts",
              ),

              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          controller.restartExam();
                          controller.startTime = DateTime.now();
                          controller.startTimer();
                        },
                        borderRadius: BorderRadius.circular(16),
                        // Consistent border radius
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          // Increased padding for better touch area
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors
                                  .mainColor, // Border color consistent with the theme
                            ),
                            borderRadius: BorderRadius.circular(12),
                            // Updated radius for modern design
                            color: AppColors.mainColor.withOpacity(0.05),
                            // Subtle background for visual appeal
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainColor.withOpacity(0.2),
                                // Soft shadow for depth
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              S.current.restart,
                              style: const TextStyle(
                                  fontSize: 18,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight
                                      .w600 // Semi-bold for a cleaner look
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Review Answer Button
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                        onTap: () async {
                          controller.saveExamResult();
                          Navigator.pop(context);
                          Get.back();
                          Get.back();
                          // await leaderboardController.fetchAllUsersData();
                          // leaderboardController.fetchUserPointsAndRank();
                          homeController.fetchAllUserExamHistory();
                        },
                        borderRadius: BorderRadius.circular(16),
                        // Updated for consistency
                        child: Container(
                          // Balanced width
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          // Better touch area
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: AppColors.mainColor),
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(12),
                            // Consistent border radius
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainColor.withOpacity(0.2),
                                // Soft shadow for depth
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).done,
                              style: const TextStyle(
                                fontSize: 18,
                                // Improved readability
                                color: AppColors.lightenMainColor,
                                // High contrast for accessibility
                                fontWeight: FontWeight
                                    .w600, // Semi-bold for modern look
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed("results");
                        },
                        // Updated for consistency
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          // Better touch area
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: AppColors.mainColor),
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.mainColor.withOpacity(0.05),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainColor.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              S.current.review,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _responsiveContainer(BuildContext context,
      {required String label, IconData? icon, Color? iconColor}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? AppColors.mainColor,
            ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
