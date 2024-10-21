import 'package:flutter/material.dart';

const Color primaryBackgroundColor = Color(0xFF663399);
const Color secondaryBackgroundColor = Color(0xFFFFFFFF);
const LinearGradient secondaryBackgroundColor_2 = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: [
    Color(0xFF743089),
    Color(0xFFBBA3C2),
  ],

  // transform: GradientRotation(),
  stops: [0.0, 1.0],
  transform: GradientRotation(171.6 * 3.14159 / 180),
);

const Color labelsColor = Color(0xFF743089);
const Color fontColor_1 = Color(0xFFFBF7FC);
const Color fontColor_2 = Color(0xFF743089);
const Color iconColor_1 = Color(0xFFFBF7FC);
const Color iconColor_2 = Color(0xFF743089);
const Color textFieldBackgroundColor = Color(0xFFFBF7FC);
const Color textFieldBorderColor = Color(0xFFBBA3C2);
