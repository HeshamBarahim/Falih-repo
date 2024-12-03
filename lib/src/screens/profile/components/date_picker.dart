import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final String dateText;
  final VoidCallback onPressed;
  const DatePicker(
      {super.key, required this.dateText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      // height: 47.0,
      height: SizeConfig.screenHeight! * .055,
      width: double.infinity,
      decoration: BoxDecoration(
        color: textFieldBackgroundColor,
        border: BorderDirectional(
          bottom: BorderSide(
            // style: BorderStyle.,
            color: textFieldBorderColor,
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
                color: fontColor_2,
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: iconColor_2,
              size: SizeConfig.screenWidth! * 0.058,
            ),
          ],
        ),
      ),
    );
  }
}
