import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownForm extends StatelessWidget {
  const CustomDropDownForm({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.list,
    required this.onChanged,
    this.selectedValue,
  });

  final String hintText;
  final Widget prefixIcon;
  final List<DropdownMenuItem<String>>? list;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        hint: Text(hintText),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.mainColor),
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.mainColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9A9393)),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(color: AppColors.shadowColor),
        onChanged: onChanged,
        items: list,
      ),
    );
  }
}
