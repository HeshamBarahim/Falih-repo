import 'package:falih/src/config/images.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String nextText;
  final String reviewAnswer;
  final String wrongAnswers;
  final String trueAnswers;
  final String numberOfQuestion;
  final String score;
  final String time;
  const CustomDialog({
    super.key,
    required this.nextText,
    required this.wrongAnswers,
    required this.trueAnswers,
    required this.numberOfQuestion,
    required this.score,
    required this.time,
    required this.reviewAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Builder(builder: (context) {
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
                    child: Center(child: Text(numberOfQuestion)),
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
                        trueAnswers,
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
                          wrongAnswers,
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
                    Text(time),
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
                  child: Center(child: Text(score))),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(child: Text(reviewAnswer)))),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          nextText,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))),
            ],
          ),
        );
      }),
    );
  }
}
