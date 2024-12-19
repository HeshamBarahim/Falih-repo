import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenHeight;
  static double? screenWidth;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * .024
        : screenWidth! * .024;

    print('The Device Default Screen Height is : $screenHeight');
    print('The Device Default Screen Width is : $screenWidth');
    print('The Device Default Screen Orientation is : $orientation');
    print('The Device Default Screen Size is : $defaultSize');
  }
}
