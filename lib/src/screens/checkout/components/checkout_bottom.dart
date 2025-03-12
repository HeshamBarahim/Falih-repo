import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes.dart';
import '../../../controller/checkout_controller.dart';

class CheckoutBottom extends StatelessWidget {
  CheckoutBottom({super.key});

  final CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Text(
          S.of(context).we_will_send,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.0142),
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              iconColor: AppColors.mainColor,
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight! * 0.0189,
                  horizontal: SizeConfig.screenWidth! * 0.194),
            ),
            icon: const Icon(Icons.payment, color: Colors.white),
            label: Text(
              S.of(context).pay_for_plan,
              style: TextStyle(
                fontSize: SizeConfig.screenWidth! * 0.0437,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: SizeConfig.screenHeight! * 0.2,
                      child: Center(
                        child: Text(S.of(context).pay_completed),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
