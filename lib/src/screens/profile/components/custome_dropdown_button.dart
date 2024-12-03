import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String value;
  final String? Function(String?) onChangedFunction;

  const CustomDropdownButton(
      {super.key, required this.value, required this.onChangedFunction});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: SizeConfig.screenWidth! * 0.0389,
          color: fontColor_2,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.0142,
          horizontal: SizeConfig.screenWidth! * 0.0486,
        ),
        filled: true,
        fillColor: textFieldBackgroundColor,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: textFieldBorderColor,
            width: SizeConfig.screenWidth! * 0.0061,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: textFieldBorderColor,
            width: SizeConfig.screenWidth! * 0.0061,
          ),
        ),
      ),
      value: value,
      style: TextStyle(
        fontSize: SizeConfig.screenWidth! * 0.041,
        color: fontColor_2,
      ),
      iconEnabledColor: iconColor_2,
      iconDisabledColor: iconColor_2,
      iconSize: SizeConfig.screenWidth! * 0.058,
      items: ['Male', 'Female']
          .map(
            (label) => DropdownMenuItem(
              child: Text(label),
              value: label,
            ),
          )
          .toList(),
      onChanged: onChangedFunction,
    );
  }
}
