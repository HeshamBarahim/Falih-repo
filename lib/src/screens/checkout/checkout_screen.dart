import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/screens/checkout/components/checkout_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../config/themes.dart';
import 'components/checkout_bottom.dart';
import 'components/checkout_date_picker.dart';
import 'components/credit_card_form.dart';
import 'components/kuraimi_card_form.dart';
import 'controller/date_picker_controller.dart';
import 'controller/payment_choice_controller.dart';

class CheckoutScreen extends StatelessWidget {
  static const String scRoute = '/checkout-screen';

  CheckoutScreen({super.key});

  final PaymentChoiceController controller = Get.put(PaymentChoiceController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cardHolderName = TextEditingController();
  final TextEditingController _cvvCvcNumber = TextEditingController();

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
          style: const TextStyle(
            fontSize: 26,
            color: AppColors.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 26,
            color: AppColors.mainColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CheckoutAppBar(),
              SizedBox(height: SizeConfig.screenHeight! * 0.0414),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.102),
                child: controller.paymentType == 0
                    ? CreditCardForm(
                        formKey: _formKey,
                        cardNumber: _cardHolderName,
                        cardHolderName: _cardHolderName,
                        cvvCvcNumber: _cvvCvcNumber,
                        datePicker: GetBuilder<DatePickerController>(
                          init: DatePickerController(),
                          builder: (controller) {
                            return CheckoutDatePicker(
                              dateText: controller.selectedDate != null
                                  ? '${controller.selectedDate!.year}/${controller.selectedDate!.month}/${controller.selectedDate!.day}'
                                  : '${controller.currentDate.year}/${controller.currentDate.month}/${controller.currentDate.day}',
                              // Display selected date or hint,
                              onPressed: () {
                                controller.dateSelectList(context);
                              },
                            );
                          },
                        ),
                      )
                    : KuraimiCardForm(
                        formKey: _formKey,
                        cardNumber: _cardHolderName,
                        cardHolderName: _cardHolderName,
                      ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.038),
              CheckoutBottom(formKey: _formKey),
            ],
          ),
        ),
      ),
    );
  }
}
