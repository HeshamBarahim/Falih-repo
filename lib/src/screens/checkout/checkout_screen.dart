import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/screens/checkout/components/checkout_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../controller/checkout_controller.dart';
import 'components/checkout_bottom.dart';
import 'components/credit_card_form.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  static const String scRoute = '/checkout-screen';

  final CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          S.of(context).check_details,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CheckoutAppBar(),
              SizedBox(height: SizeConfig.screenHeight! * 0.0414),
              CreditCardForm(),
              SizedBox(height: SizeConfig.screenHeight! * 0.038),
              CheckoutBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
