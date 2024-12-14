import 'package:falih/src/config/sizes.dart';
import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckoutTextfield extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? Function(String?) onChangedFunction;
  final FilteringTextInputFormatter inputFormatters;
  final IconData? icon;
  final String hintText;

  const CheckoutTextfield(
      {super.key,
      required this.label,
      required this.inputType,
      required this.controller,
      required this.validator,
      required this.onChangedFunction,
      required this.inputFormatters,
      required this.icon,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.0388,
            color: AppColors.darkMainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.0047),
        TextFormField(
          keyboardType: inputType,
          controller: controller,
          validator: validator,
          onChanged: onChangedFunction,
          inputFormatters: [inputFormatters],
          style: TextStyle(
            fontSize: SizeConfig.screenWidth! * 0.0389,
            color: AppColors.darkMainColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: SizeConfig.screenWidth! * 0.0389,
              color: Colors.grey.shade500,
            ),
            suffixIcon: label == 'Account Number'
                ? SizedBox(
                    width: SizeConfig.screenWidth! * 0.218,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 0.045,
                          // child: Image.asset(
                          //   'assets/images/masterCard.png',
                          //   // fit: BoxFit.fill,
                          // ),
                        ),
                        SizedBox(width: SizeConfig.screenWidth! * 0.0073),
                        Icon(
                          Icons.credit_card,
                          color: const Color(0XFFBBA3C2),
                          size: SizeConfig.screenWidth! * 0.058,
                        ),
                        SizedBox(width: SizeConfig.screenWidth! * 0.0243),
                      ],
                    ),
                  )
                : label == 'Kuraimi Card Number'
                    ? SizedBox(
                        width: SizeConfig.screenWidth! * 0.218,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: SizeConfig.screenHeight! * 0.019,
                              // child: Image.asset(
                              //   'assets/images/K_icon Black.png',
                              //   // fit: BoxFit.fill,
                              // ),
                            ),
                            SizedBox(width: SizeConfig.screenWidth! * 0.0193),
                            Icon(
                              Icons.credit_card,
                              color: const Color(0XFFBBA3C2),
                              size: SizeConfig.screenWidth! * 0.058,
                            ),
                            SizedBox(width: SizeConfig.screenWidth! * 0.0243),
                          ],
                        ),
                      )
                    : icon != null
                        ? Icon(
                            icon,
                            color: const Color(0XFFBBA3C2),
                            size: SizeConfig.screenWidth! * 0.058,
                          )
                        : null,
            // contentPadding: EdgeInsets.symmetric(
            //   vertical: SizeConfig.screenHeight! * 0.0142,
            //   horizontal: SizeConfig.screenWidth! * 0.0486,
            // ),
            filled: true,
            fillColor: Colors.white,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: const Color(0xFF743089),
                width: SizeConfig.screenWidth! * 0.0081,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: const Color(0xFF743089),
                width: SizeConfig.screenWidth! * 0.0081,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.red,
                width: SizeConfig.screenWidth! * 0.0081,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: const Color(0xFF743089),
                width: SizeConfig.screenWidth! * 0.0081,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: const Color(0xFF743089),
                width: SizeConfig.screenWidth! * 0.0081,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: const Color(0xFF743089),
                width: SizeConfig.screenWidth! * 0.0081,
              ),
            ),
          ),
        )
      ],
    );
  }
}
