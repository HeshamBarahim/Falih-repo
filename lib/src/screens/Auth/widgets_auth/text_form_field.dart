import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        validator: validator,
        controller: myController,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.mainColor),
            prefixIcon: prefixIcon,
            prefixIconColor: AppColors.mainColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.warningColor),
                borderRadius: BorderRadius.circular(20)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF9A9393)))),
      ),
    );
  }
}
