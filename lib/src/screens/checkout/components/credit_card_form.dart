import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/checkout_controller.dart';
import '../../../helper/helper_controller.dart';
import '../../Auth/widgets_auth/text_form_field.dart';

class CreditCardForm extends StatelessWidget {
  CreditCardForm({super.key});

  final CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomTextForm(
            keyFormatter: true,
            keyboardType: TextInputType.number,
            myController: controller.cardNumber,
            validator: Helper.validatePhoneNumber,
            labelText: S.of(context).kurami_card,
            prefixIcon: const Icon(
              Icons.credit_card,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.0296),
          CustomTextForm(
            keyFormatter: false,
            keyboardType: TextInputType.text,
            myController: controller.cardName,
            validator: Helper.validatefullName,
            labelText: S.of(context).hint_text_fullname,
            prefixIcon: const Icon(
              Icons.account_circle,
            ),
          ),
        ],
      ),
    );
  }
}
