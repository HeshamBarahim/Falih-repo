import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';

import '../../../config/sizes.dart';

class CustomDropDownForm extends StatelessWidget {
  const CustomDropDownForm({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.list,
    required this.onChanged,
    this.selectedValue,
    required this.validator,
  });

  final String hintText;
  final Widget prefixIcon;
  final List<DropdownMenuItem<String>>? list;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField<String>(
        validator: validator,
        value: selectedValue,
        isExpanded: false,
        // Ensures the button width matches the dropdown
        decoration: InputDecoration(
          alignLabelWithHint: true,
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 16, color: AppColors.hintColor, height: 2),
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.mainColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          filled: true,
          
          fillColor: Colors.white,
          errorStyle: TextStyle(
              color: Colors.red, fontSize: SizeConfig.screenWidth! * 0.02875),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: AppColors.mainColor,
                width: SizeConfig.screenWidth! * 0.0026),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: AppColors.mainColor,
                width: SizeConfig.screenWidth! * 0.0026),
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
        icon: Icon(
          Icons.arrow_drop_down,
          size: SizeConfig.screenWidth! * 0.06,
          color: AppColors.darkMainColor,
        ),
        // style: TextStyle(
        //     color: AppColors.mainColor,
        //     fontSize: SizeConfig.screenHeight! * 0.024),
        onChanged: onChanged,
        items: list,
      ),
    );
  }
}
