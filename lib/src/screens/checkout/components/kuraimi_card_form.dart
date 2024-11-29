import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'checkout_textfield.dart';

class KurimiCardForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController cardNumber;

  final TextEditingController cardHolderName;

  // final TextEditingController cvv_cvcNumber;

  // final Widget datePicker;

  const KurimiCardForm({
    super.key,
    required this.formKey,
    required this.cardNumber,
    required this.cardHolderName,
    // required this.cvv_cvcNumber,
    // required this.datePicker,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          CheckoutTextfield(
            label: 'Kuraimi Card Number',
            inputType: TextInputType.number,
            controller: cardNumber,
            validator: (val) {
              //
              if (val == null || val.isEmpty) {
                return 'Please Enter Your Card Number';
              }
              return null;
            },
            onChangedFunction: (val) {
              return null;

              //
            },
            inputFormatters: FilteringTextInputFormatter.deny(RegExp(r'\s')),
            icon: Icons.credit_card,
            hintText: 'Ex: 5261 4141 0151 8472',
          ),
          ////////////////////
          SizedBox(height: SizeConfig.screenHeight! * 0.0296),
          ////////////////////
          CheckoutTextfield(
            label: 'Card Holder Name',
            inputType: TextInputType.name,
            controller: cardHolderName,
            validator: (val) {
              //
              if (val == null || val.isEmpty) {
                return 'Please Enter The Card Holder Name';
              }
              return null;
            },
            onChangedFunction: (val) {
              return null;

              //
            },
            inputFormatters: FilteringTextInputFormatter.deny(RegExp(r'\s')),
            icon: null,
            hintText: 'Ex: Isaac Edwards',
          ),
          ////////////////////
          SizedBox(height: SizeConfig.screenHeight! * 0.0296),
          ////////////////////
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Expire date',
          //             style: TextStyle(
          //               fontSize: SizeConfig.screenWidth! * 0.0388,
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(height: SizeConfig.screenHeight! * 0.0094),
          //           // datePicker,
          //         ],
          //       ),
          //     ),
          //     ////////////////////
          //     SizedBox(width: SizeConfig.screenWidth! * 0.085),
          //     ////////////////////
          //     Expanded(
          //       child: CheckoutTextfield(
          //         label: 'CVV / CVC',
          //         inputType: TextInputType.number,
          //         controller: cvv_cvcNumber,
          //         validator: (val) {
          //           //
          //           if (val == null || val.isEmpty) {
          //             return 'Please Enter Your CVV / CVC Number';
          //           }
          //         },
          //         onChangedFunction: (val) {
          //           //
          //         },
          //         inputFormatters:
          //             FilteringTextInputFormatter.deny(RegExp(r'\s')),
          //         icon: Icons.info_rounded,
          //         hintText: 'Ex: 915',
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
