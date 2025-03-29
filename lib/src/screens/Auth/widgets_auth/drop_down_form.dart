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
        dropdownColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
        ),
        onChanged: onChanged,
        items: list,
      ),
    );
  }
}
