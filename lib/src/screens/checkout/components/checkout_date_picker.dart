import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

class CheckoutDatePicker extends StatelessWidget {
  final String dateText;
  final VoidCallback onPressed;

  const CheckoutDatePicker(
      {super.key, required this.dateText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      // height: 47.0,
      height: SizeConfig.screenHeight! * .055,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          bottom: BorderSide(
            // style: BorderStyle.,
            color: const Color(0xFF743089),
            width: SizeConfig.screenWidth! * 0.0041,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.screenHeight! * 0.0142,
            horizontal: SizeConfig.screenWidth! * 0.0386,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateText,
              style: TextStyle(
                fontSize: SizeConfig.screenWidth! * 0.0389,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: const Color(0xFFBBA3C2),
              size: SizeConfig.screenWidth! * 0.058,
            ),
          ],
        ),
      ),
    );
  }
}
