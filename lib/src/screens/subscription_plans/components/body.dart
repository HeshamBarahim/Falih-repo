import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/controller/subscription_plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes.dart';
import '../../../constants/functions.dart';

class Body extends StatelessWidget {
  Body({super.key});

  final SubscriptionPlansController controller =
      Get.find<SubscriptionPlansController>();

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
        height: SizeConfig.screenHeight! * 0.45,
        child: Column(
          children: [
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
                    S.of(context).arabic_section,
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
                    S.of(context).english_section,
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
                                ? Theme.of(context).colorScheme.secondary
                                : AppColors.hintColor,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth! * 0.029),
                          ),
                          padding:
                              EdgeInsets.all(SizeConfig.screenWidth! * 0.048),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${getCustomPlanName(plan['id'])} - ${S.of(context).class_text} ${plan['class']}',
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: SizeConfig.screenWidth! * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: controller.selectedPlan.value?["id"] ==
                                          planIdentifier
                                      ? Theme.of(context).colorScheme.primary
                                      : AppColors.lightenMainColor,
                                ),
                              ),
                              SizedBox(
                                  height: SizeConfig.screenHeight! * 0.012),
                              plan['durationInDays'] != 0
                                  ? Text(
                                      "${plan['price'] ?? 0} ${S.of(context).ry_for} ${plan['durationInDays'] ?? ''} ${S.of(context).days}",
                                      style: TextStyle(
                                        color: controller.selectedPlan
                                                    .value?["id"] ==
                                                planIdentifier
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : AppColors.lightenMainColor,
                                        fontSize:
                                            SizeConfig.screenWidth! * 0.035,
                                      ),
                                    )
                                  : Text(
                                      "${plan['price'] ?? 0} ${S.of(context).ry_for} ${plan['unitExamLimit'] ?? ''} ${S.of(context).unit_exams} & ${plan['finalExamLimit'] ?? ''} ${S.of(context).final_exams}",
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
    });
  }

}
