import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/sizes.dart';

class CustomPasswordTextForm extends StatelessWidget {
  final TextEditingController myController;
  final String? Function(String?)? validator;
  final bool obscureText;
  // final bool keyFormatter;
  final String labelText;
  final Widget prefixIcon;
  final VoidCallback showPasswordFunction;

  const CustomPasswordTextForm({
    super.key,
    required this.myController,
    this.validator,
    required this.obscureText,
    // required this.keyFormatter,
    required this.labelText,
    required this.prefixIcon,
    required this.showPasswordFunction,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        // 1
        controller: myController,
        // 2
        validator: validator,
        // 3
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        // 4
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
          LengthLimitingTextInputFormatter(20),
        ],
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
              color: AppColors.hintColor),
          errorStyle: TextStyle(
              color: Colors.red, fontSize: SizeConfig.screenWidth! * 0.03875),
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.mainColor,
          suffixIcon: IconButton(
            icon: Icon(
              obscureText == true ? Icons.visibility : Icons.visibility_off,
              size: SizeConfig.screenHeight! * 0.03,
            ),
            onPressed: showPasswordFunction,
          ),
          suffixIconColor: AppColors.mainColor,
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
