import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/sizes.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController myController;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool keyFormatter;
  final String labelText;
  final Widget prefixIcon;

  const CustomTextForm(
      {super.key,
      required this.myController,
      this.validator,
      required this.keyboardType,
      required this.keyFormatter,
      required this.labelText,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.007,
          horizontal: SizeConfig.screenWidth! * 0.0097),
      child: TextFormField(
        // 1
        controller: myController,
        // 2
        validator: validator,
        // 3
        keyboardType: keyboardType,
        
        // 4
        inputFormatters: keyFormatter == true
            ? [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ]
            : null,
        style: TextStyle(
          fontSize: SizeConfig.screenWidth! * 0.038,
          color: AppColors.mainColor,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          // 5
          // hintText: 'hintText',
          // hintStyle: TextStyle(
          //     fontSize: SizeConfig.screenWidth! * 0.03875, color: Colors.grey),
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: SizeConfig.screenWidth! * 0.03875,
              color: AppColors.mainColor),
          errorStyle: TextStyle(
              color: Colors.red, fontSize: SizeConfig.screenWidth! * 0.03875),
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.mainColor,
          contentPadding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight! * 0.00118,
              horizontal: SizeConfig.screenWidth! * 0.048),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth! * 0.0486),
            borderSide: BorderSide(
                color: AppColors.mainColor,
                width: SizeConfig.screenWidth! * 0.0026),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.mainColor,
                width: SizeConfig.screenWidth! * 0.0046),
            borderRadius: BorderRadius.all(
              Radius.circular(SizeConfig.screenWidth! * 0.0486),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: SizeConfig.screenWidth! * 0.0026),
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth! * 0.0486),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: SizeConfig.screenWidth! * 0.0046),
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth! * 0.0486),
          ),
        ),
      ),
    );
  }
}
