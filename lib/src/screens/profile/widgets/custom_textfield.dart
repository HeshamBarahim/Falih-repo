import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CostomTextField extends StatelessWidget {
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? Function(String?) onChangedFunction;
  final FilteringTextInputFormatter inputFormatters;
  final String hintText;

  const CostomTextField({
    super.key,
    required this.inputType,
    required this.controller,
    required this.validator,
    required this.onChangedFunction,
    required this.inputFormatters,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      validator: validator,
      onChanged: onChangedFunction,
      inputFormatters: [inputFormatters],
      style: TextStyle(
        fontSize: SizeConfig.screenWidth! * 0.0389,
        color: fontColor_2,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: SizeConfig.screenWidth! * 0.0389,
          color: fontColor_2,
        ),
        prefixIcon: inputType == TextInputType.phone
            ? Icon(
                Icons.phone,
                color: iconColor_2,
                size: SizeConfig.screenWidth! * 0.058,
              )
            : null,
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
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.red,
            width: SizeConfig.screenWidth! * 0.0061,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: textFieldBorderColor,
            width: SizeConfig.screenWidth! * 0.0061,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: textFieldBorderColor,
            width: SizeConfig.screenWidth! * 0.0061,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: textFieldBorderColor,
            width: SizeConfig.screenWidth! * 0.0061,
          ),
        ),
      ),
    );
  }
}
