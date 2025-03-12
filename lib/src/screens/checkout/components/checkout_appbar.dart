import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/subscription_plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/checkout_controller.dart';
import 'checkout_button.dart';

class CheckoutAppBar extends StatelessWidget {
  CheckoutAppBar({super.key});

  final CheckoutController paymentController = Get.put(CheckoutController());

  final SubscriptionPlansController controller =
      Get.put(SubscriptionPlansController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        /// Payment Title & Details
        Container(
          height: SizeConfig.screenHeight! * 0.2948,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: SizeConfig.screenWidth! * 0.00543,
                strokeAlign: .9,
                style: BorderStyle.solid,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.0237),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan Details Section
                  Center(
                    child: Text(S.of(context).plan_details,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).plan,
                      ),
                      Text(
                        '${controller.selectedPlan.value?["name"] ?? S.of(context).no_plan_selected}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).type,
                      ),
                      Text(
                        controller.selectedPlan.value?["type"]
                                .toString()
                                .capitalize ??
                            S.of(context).no_plan_selected,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).class_text,
                      ),
                      Text(
                        '${controller.selectedPlan.value?["class"] ?? S.of(context).no_plan_selected}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).section,
                      ),
                      Text(
                        controller.selectedPlan.value?["section"]
                                .toString()
                                .capitalize ??
                            S.of(context).no_plan_selected,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).price,
                      ),
                      Text(
                        "${controller.selectedPlan.value!["price"]}",
                      ),
                    ],
                  ),
                  controller.selectedPlan.value?["durationInDays"] != 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).duration,
                            ),
                            Text(
                              '${controller.selectedPlan.value!["durationInDays"]} ${S.of(context).days}',
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).unit_exam_limit,
                                ),
                                Text(
                                  '${controller.selectedPlan.value!["unitExamLimit"]} ${S.of(context).times}',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).final_exam_limit,
                                ),
                                Text(
                                  '${controller.selectedPlan.value!["finalExamLimit"]} ${S.of(context).times}',
                                ),
                              ],
                            ),
                          ],
                        )
                ],
              ),
            ],
          ),
        ),

        /// Payment Type Choices Buttons
        CheckoutButton(
            creditBackgroundColor: paymentController.paymentType == 0
                ? AppColors.darkMainColor
                : AppColors.lightenMainColor,
            creditCardOnPressed: () {},
            creditIconColor: paymentController.paymentType == 0
                ? Colors.white
                : Colors.black,
            creditTextColor: paymentController.paymentType == 0
                ? Colors.white
                : Colors.black,
            kuraimiBackgroundColor: paymentController.paymentType == 1
                ? AppColors.darkMainColor
                : AppColors.lightenMainColor,
            kuraimiOnPressed: () {
            },
            kuraimiIconColor: paymentController.paymentType == 1
                ? Colors.white
                : Colors.black,
            kuraimiTextColor: paymentController.paymentType == 1
                ? Colors.white
                : Colors.black)
      ],
    );
  }
}
