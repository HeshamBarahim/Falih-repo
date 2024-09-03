import 'package:flutter/material.dart';
import 'package:falih/src/config/themes.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;

  const CustomTextForm({
    super.key,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        // validator: validator ,
        // controller: myController ,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 14, color: AppColors.shadowColor),
            prefixIcon: prefixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF9A9393)))),
      ),
    );
  }
}
