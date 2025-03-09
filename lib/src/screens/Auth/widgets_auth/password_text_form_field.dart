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
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: IconButton(
            icon: Icon(
              obscureText == true ? Icons.visibility : Icons.visibility_off,
              size: SizeConfig.screenHeight! * 0.03,
            ),
            onPressed: showPasswordFunction,
          ),
        ),
      ),
    );
  }
}
