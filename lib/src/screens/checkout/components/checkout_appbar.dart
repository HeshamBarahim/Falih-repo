import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

import 'payment_choice_button.dart';

class CheckoutAppBar extends StatelessWidget {
  final int paymentType;
  final String price;
  final VoidCallback creditCardFunction;
  final VoidCallback kuraimiFunction;

  const CheckoutAppBar(
      {super.key,
      required this.paymentType,
      required this.price,
      required this.creditCardFunction,
      required this.kuraimiFunction});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        /// Payment Title & Details
        Container(
          height: SizeConfig.screenHeight! * 0.2548,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.0388),
          decoration: BoxDecoration(
            /// shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(
                color: const Color(0XFF743089),
                width: SizeConfig.screenWidth! * 0.00543,
                strokeAlign: .9,
                style: BorderStyle.solid,
              ),
            ),
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              ///
              /// Back Button
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: SizeConfig.screenWidth! * 0.078,
                  color: iconColor_2,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              ///
              ///
              /// Payment Title
              Center(
                child: Text(
                  'Checkout Details',
                  style: TextStyle(
                    fontSize: SizeConfig.screenWidth! * 0.063,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.0237),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.13),

                ///
                ///
                /// Payment Details
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'For payment:',
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth! * 0.036,
                        color: const Color(0XFFBBA3C2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          // '\$240,55',
                          style: TextStyle(
                            // fontSize: SizeConfig.screenWidth! * 0.029,
                            fontSize: SizeConfig.screenWidth! * 0.036,
                            fontWeight: FontWeight.bold,
                            color: const Color(0XFF3CD797),
                          ),
                        ),
                        Text(
                          'Including VAT (21%)',
                          style: TextStyle(
                            // fontSize: SizeConfig.screenWidth! * 0.029,
                            fontSize: SizeConfig.screenWidth! * 0.031,
                            color: const Color(0XFFBBA3C2),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        ///
        ///
        /// Payment Type Choices Buttons
        PaymentChoiceButton(
            creditBackgroundColor: paymentType == 0
                ? const Color(0xFF743089)
                : Colors.grey.shade300,
            creditCardOnPressed: () {
              // setState(() {
              //   paymentType = 0;
              // });
              creditCardFunction();
            },
            creditIconColor: paymentType == 0 ? Colors.white : Colors.black,
            creditTextColor: paymentType == 0 ? Colors.white : Colors.black,
            kuraimiBackgroundColor: paymentType == 1
                ? const Color(0xFF743089)
                : Colors.grey.shade300,
            kuraimiOnPressed: () {
              // setState(() {
              //   paymentType = 1;
              // });
              kuraimiFunction();
            },
            kuraimiIconColor: paymentType == 1 ? Colors.white : Colors.black,
            kuraimiTextColor: paymentType == 1 ? Colors.white : Colors.black)
      ],
    );
  }
}
