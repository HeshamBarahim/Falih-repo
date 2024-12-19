import 'package:falih/generated/l10n.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentChoiceButton extends StatelessWidget {
  final Color creditBackgroundColor;
  final VoidCallback creditCardOnPressed;
  final Color creditIconColor;
  final Color creditTextColor;

  final Color kuraimiBackgroundColor;
  final VoidCallback kuraimiOnPressed;
  final Color kuraimiIconColor;
  final Color kuraimiTextColor;

  const PaymentChoiceButton(
      {super.key,
      required this.creditBackgroundColor,
      required this.creditCardOnPressed,
      required this.creditIconColor,
      required this.creditTextColor,
      required this.kuraimiBackgroundColor,
      required this.kuraimiOnPressed,
      required this.kuraimiIconColor,
      required this.kuraimiTextColor});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(
          right: SizeConfig.screenWidth! * 0.097,
          left: SizeConfig.screenWidth! * 0.097,
          top: SizeConfig.screenHeight! * 0.358),
      height: SizeConfig.screenHeight! * 0.071,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight! * 0.022),
        color: const Color(0xFFEFF0F1).withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 450,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth! * 0.048),
                ),
                backgroundColor: creditBackgroundColor,
                // paymentType == 0 ? Color(0xFF743089) : Colors.grey.shade300,
              ),
              onPressed: creditCardOnPressed,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.creditcard_fill,
                      // color: paymentType == 0 ? Colors.white : Colors.black,
                      color: creditIconColor,
                      size: SizeConfig.screenWidth! * 0.060,
                    ),
                    Text(
                      S.of(context).kuraimi,
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth! * 0.038,
                        // color: paymentType == 0 ? Colors.white : Colors.black,
                        color: creditTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Apple Pay Button
          SizedBox(
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth! * 0.048),
                ),
                backgroundColor: kuraimiBackgroundColor,
              ),
              onPressed: kuraimiOnPressed,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.apple,
                      color: kuraimiIconColor,
                      size: SizeConfig.screenWidth! * 0.060,
                    ),
                    Text(
                      S.of(context).jaib,
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth! * 0.035,
                        color: kuraimiTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
