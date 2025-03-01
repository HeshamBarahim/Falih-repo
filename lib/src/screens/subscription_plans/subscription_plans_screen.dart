import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:falih/src/controller/subscription_plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main_screen/main_screen.dart';
import 'components/body.dart';
import 'components/footer.dart';
import 'components/header.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  SubscriptionPlansScreen({super.key});

  static const String subscriptionRoute = '/subscription-screen';
  final SubscriptionPlansController controller =
      Get.put(SubscriptionPlansController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: AppColors.secondaryBackgroundColor_2),
          child: Padding(
            padding: const EdgeInsets.all(8),
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
                    Get.offAll(MainScreen());
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
                        backgroundColor: AppColors.mainColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth! * 0.029),
                        ),
                      ),
                      onPressed: controller.selectedPlan.value != null
                          ? () {
                              Get.toNamed("checkout");
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
                const Spacer(),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
