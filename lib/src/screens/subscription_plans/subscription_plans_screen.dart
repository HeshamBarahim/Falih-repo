import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/subscription_plans_controller.dart';
import 'package:falih/src/screens/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main_screen/menu_screen.dart';
import 'components/body.dart';
import 'components/footer.dart';
import 'components/header.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  SubscriptionPlansScreen({super.key});

  static const String SUBSCRIPTION_ROUTE = '/subscription-screen';
  final SubscriptionPlansController controller =
      Get.put(SubscriptionPlansController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Navigate to the menu screen when the user tries to pop
          Get.offAll(MenuScreen());
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: secondaryBackgroundColor_2),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.secondaryColor,
                    size: SizeConfig.screenWidth! * 0.085,
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    Get.offAll(MenuScreen());
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.018),
                // Header
                const Header(),
                const SizedBox(
                  height: 10,
                ),
                //Body
                // Plan options
                Body(),
                const Spacer(),
                // Checkout Button
                Obx(
                  () => Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // was primary change it to primary
                        backgroundColor: AppColors.mainColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth! * 0.17,
                          vertical: SizeConfig.screenHeight! * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth! * 0.029),
                        ),
                      ),
                      onPressed: controller.selectedPlan.value != null
                          ? () {
                              Get.to(CheckoutScreen());
                            }
                          : null,
                      child: Text(
                        S.of(context).check_out,
                        style: TextStyle(
                          fontSize: SizeConfig.screenWidth! * 0.043,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.screenHeight! * 0.024),
                // Footer
                // Terms and Privacy
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
