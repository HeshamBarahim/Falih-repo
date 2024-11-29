import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/screens/checkout/components/checkout_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/checkout_bottom.dart';
import 'components/checkout_date_picker.dart';
import 'components/credit_card_form.dart';
import 'components/kuraimi_card_form.dart';
import 'controller/date_picker_controller.dart';
import 'controller/payment_choice_controller.dart';

class CheckoutScreen extends StatelessWidget {
  static const String sc_route = '/checkout-screen';

  CheckoutScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumber = TextEditingController();

  final TextEditingController _cardHolderName = TextEditingController();

  final TextEditingController _cvv_cvcNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ////////////////////
              /// Header(AppBar):
              GetBuilder<PaymentChoiceController>(
                init: PaymentChoiceController(),
                builder: (controller) {
                  return CheckoutAppBar(
                    paymentType: controller.paymentType,
                    price: '\$240.55',
                    creditCardFunction: () {
                      // setState(() {
                      //   controller.paymentType = 0;
                      // });
                      controller.creditCardChoice();
                    },
                    kuraimiFunction: () {
                      // setState(() {
                      //   paymentType = 1;
                      // });
                      controller.kuraimiChoice();
                    },
                  );
                },
              ),
              /////////////////////
              SizedBox(height: SizeConfig.screenHeight! * 0.0414),
              /////////////////////
              /// Body (Payment Form)
              /// The Form Ubon Payment Type
              GetBuilder<PaymentChoiceController>(
                init: PaymentChoiceController(),
                builder: (controller) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth! * 0.102),
                    child: controller.paymentType == 0
                        ? CreditCardForm(
                            formKey: _formKey,
                            cardNumber: _cardHolderName,
                            cardHolderName: _cardHolderName,
                            cvv_cvcNumber: _cvv_cvcNumber,
                            datePicker: GetBuilder<DatePickerController>(
                              init: DatePickerController(),
                              builder: (controller) {
                                return CheckoutDatePicker(
                                  dateText: controller.selectedDate != null
                                      ? '${controller.selectedDate!.year}/${controller.selectedDate!.month}/${controller.selectedDate!.day}'
                                      : '${controller.currentDate.year}/${controller.currentDate.month}/${controller.currentDate.day}', // Display selected date or hint,
                                  onPressed: () {
                                    controller.dateSelectList(context);
                                  },
                                );
                              },
                            ),
                          )
                        : KurimiCardForm(
                            formKey: _formKey,
                            cardNumber: _cardHolderName,
                            cardHolderName: _cardHolderName,
                          ),
                  );
                },
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
