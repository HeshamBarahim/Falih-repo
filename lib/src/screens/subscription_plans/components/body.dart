import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/controller/subscription_plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes.dart';

class Body extends StatelessWidget {
  Body({super.key});

  final SubscriptionPlansController controller =
      Get.put(SubscriptionPlansController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      if (controller.plans.isEmpty) {
        return const Center(child: Text('No plans found'));
      }

      return SizedBox(
        height: 300,
        child: Column(
          children: [
            // Buttons to select section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.selectSection("arabic");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor:
                        controller.selectedSection.value == "arabic"
                            ? AppColors.lightenMainColor // Selected class color
                            : AppColors.darkMainColor, // Default color
                  ),
                  child: Text(
                    'Arabic section',
                    style: TextStyle(
                        color: controller.selectedSection.value == "arabic"
                            ? AppColors.darkMainColor // Default color
                            : AppColors.lightenMainColor // Selected class color
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.selectSection("english");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor:
                        controller.selectedSection.value == "english"
                            ? AppColors.lightenMainColor // Selected class color
                            : AppColors.darkMainColor,
                    // Default color
                  ),
                  child: Text(
                    'English section',
                    style: TextStyle(
                        color: controller.selectedSection.value == "english"
                            ? AppColors.darkMainColor // Default color
                            : AppColors.lightenMainColor // Selected class color
                        ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.filteredPlans.length,
                  itemBuilder: (context, index) {
                    final plan = controller.filteredPlans[index];
                    final planIdentifier = plan["id"];
                    return GestureDetector(
                      onTap: () {
                        if (controller.selectedPlan.value?["id"] ==
                            planIdentifier) {
                          controller.selectedPlan.value = null;
                        } else {
                          controller.selectPlan(plan);
                        }
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: controller.selectedPlan.value?["id"] ==
                                    planIdentifier
                                ? AppColors.darkMainColor
                                : AppColors.lightenMainColor,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth! * 0.029),
                          ),
                          padding:
                              EdgeInsets.all(SizeConfig.screenWidth! * 0.048),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${plan['name'] ?? "Plan Name"} - Class ${plan['class']}',
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: SizeConfig.screenWidth! * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: controller.selectedPlan.value?["id"] ==
                                          planIdentifier
                                      ? AppColors.lightenMainColor
                                      : AppColors.mainColor,
                                ),
                              ),
                              SizedBox(
                                  height: SizeConfig.screenHeight! * 0.012),
                              plan['durationInDays'] != 0
                                  ? Text(
                                      "${plan['price'] ?? 0} r.y for ${plan['durationInDays'] ?? ''} Days",
                                      style: TextStyle(
                                        color: controller.selectedPlan
                                                    .value?["id"] ==
                                                planIdentifier
                                            ? AppColors.lightenMainColor
                                            : AppColors.mainColor,
                                        fontSize:
                                            SizeConfig.screenWidth! * 0.035,
                                      ),
                                    )
                                  : Text(
                                      "${plan['price'] ?? 0} r.y for ${plan['unitExamLimit'] ?? ''} Unit Exams & ${plan['finalExamLimit'] ?? ''} Final Exams",
                                      style: TextStyle(
                                        color: controller.selectedPlan
                                                    .value?["id"] ==
                                                planIdentifier
                                            ? AppColors.lightenMainColor
                                            : AppColors.mainColor,
                                        fontSize:
                                            SizeConfig.screenWidth! * 0.030,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
      // return Column(
      //   children: [
      //     // Plan options
      //     Container(
      //       decoration: BoxDecoration(
      //         color: AppColors.darkMainColor,
      //         borderRadius:
      //         BorderRadius.circular(SizeConfig.screenWidth! * 0.029),
      //       ),
      //       padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.048),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Annual",
      //                 style: TextStyle(
      //                   fontSize: SizeConfig.screenWidth! * 0.043,
      //                   fontWeight: FontWeight.bold,
      //                   color: Color(0xFFFBF7FC),
      //                 ),
      //               ),
      //               Container(
      //                 padding: EdgeInsets.symmetric(
      //                   horizontal: SizeConfig.screenWidth! * 0.015,
      //                   vertical: SizeConfig.screenHeight! * 0.005,
      //                 ),
      //                 decoration: BoxDecoration(
      //                   color: Colors.green,
      //                   borderRadius: BorderRadius.circular(
      //                       SizeConfig.screenWidth! * 0.024),
      //                 ),
      //                 child: Text(
      //                   "Best Value",
      //                   style: TextStyle(
      //                     fontSize: SizeConfig.screenWidth! * 0.029,
      //                     color: Color(0xFFFBF7FC),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(height: SizeConfig.screenHeight! * 0.012),
      //           Text(
      //             "First 30 days free - Then \$999/Year",
      //             style: TextStyle(
      //               color: Color(0xFFFBF7FC),
      //               fontSize: SizeConfig.screenWidth! * 0.035,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //
      //     SizedBox(height: SizeConfig.screenHeight! * 0.024),
      //
      //     Container(
      //       decoration: BoxDecoration(
      //         color: AppColors.lightenMainColor,
      //         borderRadius:
      //         BorderRadius.circular(SizeConfig.screenWidth! * 0.029),
      //       ),
      //       padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.048),
      //       child: Row(
      //         children: [
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Monthly",
      //                 style: TextStyle(
      //                   fontSize: SizeConfig.screenWidth! * 0.043,
      //                   fontWeight: FontWeight.bold,
      //                    AppColors.mainColor,
      //                 ),
      //               ),
      //               SizedBox(height: SizeConfig.screenHeight! * 0.012),
      //               Text(
      //                 "First 7 days free - Then \$99/Month",
      //                 style: TextStyle(
      //                    AppColors.mainColor,
      //                   fontSize: SizeConfig.screenWidth! * 0.035,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // );
    });
  }
}
