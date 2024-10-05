import 'package:flutter/material.dart';
import 'package:falih/src/config/themes.dart';

class CustomDropDownForm extends StatefulWidget {
  const CustomDropDownForm(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      required this.list});
  final String hintText;
  final Widget prefixIcon;
  final List<DropdownMenuItem<String>>? list;

  @override
  State<CustomDropDownForm> createState() => _CustomDropDownForm();
}

class _CustomDropDownForm extends State<CustomDropDownForm> {
  String? dropDownGovernorate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: DropdownButtonFormField(
          value: dropDownGovernorate,
          hint: Text(widget.hintText),
          decoration: InputDecoration(
              hintStyle:
                  const TextStyle(fontSize: 14, color: AppColors.mainColor),
              prefixIcon: widget.prefixIcon,
              prefixIconColor: AppColors.mainColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color(0xFF9A9393)))),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: AppColors.shadowColor),
          onChanged: (String? newValue) {
            setState(() {
              dropDownGovernorate = newValue!;
            });
          },
          items: widget.list),
    );
  }
}
