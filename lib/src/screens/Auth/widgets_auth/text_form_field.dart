import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/sizes.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController myController;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final TextInputType keyboardType;
  final bool keyFormatter;
  final String labelText;
  final String? errorMessage;
  final Widget prefixIcon;

  const CustomTextForm(
      {super.key,
      required this.myController,
      required this.validator,
      this.onChanged,
      this.errorMessage,
      required this.keyboardType,
      required this.keyFormatter,
      required this.labelText,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: myController,
        validator: validator,

        /// Optional
        onChanged: onChanged,

        ///

        keyboardType: keyboardType,
        inputFormatters: keyFormatter == true
            ? [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ]
            : null,
        style: const TextStyle(
          fontSize: 16,
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
          labelStyle: const TextStyle(fontSize: 16, color: AppColors.hintColor),
          errorText: errorMessage,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: SizeConfig.screenWidth! * 0.02895,
          ),

          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.mainColor,
          contentPadding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight! * 0.00118,
              horizontal: SizeConfig.screenWidth! * 0.048),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: AppColors.mainColor,
                width: SizeConfig.screenWidth! * 0.0026),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.mainColor,
                width: SizeConfig.screenWidth! * 0.0046),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: SizeConfig.screenWidth! * 0.0026),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: SizeConfig.screenWidth! * 0.0046),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
