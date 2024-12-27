import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/leaderboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../controller/exam_controller.dart';
import '../../../controller/home_controller.dart';
import '../../after_exam/after_exam.dart';

class ResultDialog extends StatelessWidget {
  final BuildContext context;

  const ResultDialog({super.key, required this.context});

  @override
  Widget build(BuildContext _context) {
    final HomeController homeController = Get.find<HomeController>();

    final ExamController controller = Get.put(ExamController());
    final LeaderboardController leaderboardController =
        Get.find<LeaderboardController>();

    return Dialog(
      child: Builder(builder: (_) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // silver image and restart button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Images.silverMedal,
                    height: 50,
                    width: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                        child: Text(controller.questions.length.toString())),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.mainColor, width: 2)),
                      child: const Icon(Icons.restart_alt_rounded),
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: AppColors.successColor.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        controller.trueAnswers.value.toString(),
                        style: const TextStyle(
                            color: AppColors.successColor,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Center(
                        child: Text(
                          controller.falseAnswers.value.toString(),
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                    color: AppColors.mainColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.mainColor,
                    ),
                    Text(controller.examTime.value.toString()),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(25)),
                  child:
                      Center(child: Text(controller.score.value.toString()))),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(_context);
                    Get.to(() => const AfterExam());
                  },
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(child: Text(S.of(context).review_answer)))),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () async {
                    final ExamController controller =
                        Get.find<ExamController>();
                    controller.saveExamResult();
                    Navigator.pop(_context);
                    Get.back();
                    Get.back();

                    await leaderboardController.fetchAllUsersData();
                    leaderboardController.fetchUserPointsAndRank();
                    homeController.fetchAllUserExamHistory();
                  },
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Builder(builder: (_) {
                          return Text(
                            S.of(context).done,
                            style: const TextStyle(color: Colors.white),
                          );
                        }),
                      ))),
            ],
          ),
        );
      }),
    );
  }
}
