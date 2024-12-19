import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

import '../../../config/themes.dart';

class CheckoutBottom extends StatelessWidget {
  const CheckoutBottom({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.1,
              vertical: SizeConfig.screenHeight! * 0.0077),
          child: Text(
            S.of(context).we_will_send,
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: SizeConfig.screenWidth! * 0.0291,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.0142),
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              iconColor: AppColors.mainColor,
              backgroundColor: AppColors.mainColor,
              // primary: Color(0xFF743089),
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
              if (formKey.currentState!.validate()) {
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
