import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController myController;
  final String? Function(String?)? validator;

  const CustomTextForm({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.myController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.007,
          horizontal: SizeConfig.screenWidth! * 0.0097),
      child: TextFormField(
        validator: validator,
        controller: myController,
        decoration: InputDecoration(
            hintText: hintText,
            // hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.mainColor),
            hintStyle: TextStyle(
                fontSize: SizeConfig.screenWidth! * 0.03875,
                color: AppColors.mainColor),
            prefixIcon: prefixIcon,
            prefixIconColor: AppColors.mainColor,
            contentPadding: EdgeInsets.symmetric(
                vertical: SizeConfig.screenHeight! * 0.00118,
                horizontal: SizeConfig.screenWidth! * 0.048),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.screenWidth! * 0.0486))),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.warningColor),
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth! * 0.0486)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth! * 0.0486)),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth! * 0.0486),
                borderSide: BorderSide(color: Color(0xFF9A9393)))),
      ),
    );
  }
}
