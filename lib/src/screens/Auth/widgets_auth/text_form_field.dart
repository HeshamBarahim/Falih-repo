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
        onChanged: onChanged,
        keyboardType: keyboardType,
        inputFormatters: keyFormatter == true
            ? [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ]
            : null,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorMessage,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
