import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/subscription_plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/payment_choice_controller.dart';
import 'payment_choice_button.dart';

class CheckoutAppBar extends StatelessWidget {
  CheckoutAppBar({super.key});

  final PaymentChoiceController paymentController =
      Get.put(PaymentChoiceController());

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
          height: SizeConfig.screenHeight! * 0.3948,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.0388),
          decoration: BoxDecoration(
            /// shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(
                color: const Color(0XFF743089),
                width: SizeConfig.screenWidth! * 0.00543,
                strokeAlign: .9,
                style: BorderStyle.solid,
              ),
            ),
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              ///
              /// Back Button
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: SizeConfig.screenWidth! * 0.078,
                  color: iconColor_2,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              Center(
                child: Text(
                  'Checkout Details',
                  style: TextStyle(
                    fontSize: SizeConfig.screenWidth! * 0.063,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.0237),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.13),

                /// Payment Details
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan Details Section
                    Text(
                      'Plan Details',
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth! * 0.04,
                        fontWeight: FontWeight.bold,
                        color: const Color(0XFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Plan:',
                          style: TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                        Text(
                          '${controller.selectedPlan.value?["name"] ?? "No Plan Selected"}',
                          style: const TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Type:',
                          style: TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                        Text(
                          controller.selectedPlan.value?["type"]
                                  .toString()
                                  .capitalize ??
                              "No Plan Selected",
                          style: const TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Class:',
                          style: TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                        Text(
                          '${controller.selectedPlan.value?["class"] ?? "No Plan Selected"}',
                          style: const TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Section:',
                          style: TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                        Text(
                          controller.selectedPlan.value?["section"]
                                  .toString()
                                  .capitalize ??
                              "No Plan Selected",
                          style: const TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                      ],
                    ),
                    // if (features.isNotEmpty)
                    //   Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: features
                    //         .map((feature) => Text(
                    //               '• $feature',
                    //               style: TextStyle(
                    //                 fontSize: SizeConfig.screenWidth! * 0.03,
                    //                 color: const Color(0XFF666666),
                    //               ),
                    //             ))
                    //         .toList(),
                    //   ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Price:',
                          style: TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                        Text(
                          '${controller.selectedPlan.value!["price"]} r.y',
                          style: const TextStyle(
                            color: Color(0XFF666666),
                          ),
                        ),
                      ],
                    ),
                    controller.selectedPlan.value?["durationInDays"] != 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Duration: ',
                                style: TextStyle(
                                  color: Color(0XFF666666),
                                ),
                              ),
                              Text(
                                '${controller.selectedPlan.value!["durationInDays"]} days',
                                style: const TextStyle(
                                  color: Color(0XFF666666),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Unit Exam Limit:',
                                    style: TextStyle(
                                      color: Color(0XFF666666),
                                    ),
                                  ),
                                  Text(
                                    '${controller.selectedPlan.value!["unitExamLimit"]} times',
                                    style: const TextStyle(
                                      color: Color(0XFF666666),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Final Exam Limit:',
                                    style: TextStyle(
                                      color: Color(0XFF666666),
                                    ),
                                  ),
                                  Text(
                                    '${controller.selectedPlan.value!["finalExamLimit"]} times',
                                    style: const TextStyle(
                                      color: Color(0XFF666666),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                    // const Divider(color: Color(0XFFCCCCCC)),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// Payment Type Choices Buttons
        PaymentChoiceButton(
            creditBackgroundColor: paymentController.paymentType == 0
                ? AppColors.darkMainColor
                : AppColors.lightenMainColor,
            creditCardOnPressed: () {
              // setState(() {
              //   paymentController.paymentType = 0;
              // });
              // creditCardFunction();
            },
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
              // setState(() {
              //   paymentController.paymentType = 1;
              // });
              // kuraimiFunction();
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
