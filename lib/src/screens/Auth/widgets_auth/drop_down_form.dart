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
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.0097,
          vertical: SizeConfig.screenHeight! * 0.007),
      child: DropdownButtonFormField<String>(
        validator: validator,
        value: selectedValue,
        hint: Text(hintText),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontSize: SizeConfig.screenHeight! * 0.024,
              color: AppColors.mainColor),
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.mainColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.screenHeight! * 0.02),
            borderSide: const BorderSide(color: Color(0xFF9A9393)),
          ),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          size: SizeConfig.screenWidth! * 0.06,
        ),
        style: TextStyle(
            color: AppColors.shadowColor,
            fontSize: SizeConfig.screenHeight! * 0.024),
        onChanged: onChanged,
        items: list,
      ),
    );
  }
}
