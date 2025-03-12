import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/checkout_controller.dart';

class CheckoutButton extends StatelessWidget {
  final Color creditBackgroundColor;
  final VoidCallback creditCardOnPressed;
  final Color creditIconColor;
  final Color creditTextColor;

  final Color kuraimiBackgroundColor;
  final VoidCallback kuraimiOnPressed;
  final Color kuraimiIconColor;
  final Color kuraimiTextColor;

  CheckoutButton(
      {super.key,
      required this.creditBackgroundColor,
      required this.creditCardOnPressed,
      required this.creditIconColor,
      required this.creditTextColor,
      required this.kuraimiBackgroundColor,
      required this.kuraimiOnPressed,
      required this.kuraimiIconColor,
      required this.kuraimiTextColor});

  final CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(
          right: SizeConfig.screenWidth! * 0.097,
          left: SizeConfig.screenWidth! * 0.097,
          top: SizeConfig.screenHeight! * 0.258),
      height: SizeConfig.screenHeight! * 0.071,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight! * 0.022),
        // color: const Color(0xFFEFF0F1).withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 450,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(controller.paymentOptions.length, (index) {
            bool isSelected = controller.selectedIndex.value == index;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => controller.selectPayment(index),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.paymentOptions[index]["icon"],
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        controller.paymentOptions[index]["title"],
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
