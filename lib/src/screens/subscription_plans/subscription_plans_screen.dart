import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/controller/subscription_plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            S.of(context).subscription_packages,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(
                height: 10,
              ),
              Body(),
              const Spacer(),
              // Checkout Button
              Obx(
                () => Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
                    child: Text(S.of(context).check_out,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Get.isDarkMode
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).primaryColor,
                                )),
                  ),
                ),
              ),
              const Spacer(),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
