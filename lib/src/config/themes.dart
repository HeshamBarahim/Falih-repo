import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient secondaryBackgroundColor_2 = LinearGradient(
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

  static const LinearGradient primaryGradients = LinearGradient(colors: [
    Color(0xFFF79334),
    Color(0xFFF33E62),
    Color(0xFF548AD8),
  ]);
  static const mainColor = Color(0xFF743089);
  static const secondaryColor = Color(0xFFFBF7FC);
  static const darkMainColor = Color(0xFF532262);
  static const choicesColor = Color(0xFFE4CAEC);
  static const successColor = Color(0xFF3CD797);
  static const successDarkColor = Color(0xFF319e71);
  static const errorColor = Color(0xFFFE2712);
  static const successBoxColor = Color(0x333CD797);
  static const errorBoxColor = Color(0x33FE2712);
  static const lightenMainColor = Color(0xFFE4CAEC);
  static const moreLightenMainColor = Color(0xFFF7F0FA);

  static const hintColor = Color(0xFFA56CB3); // Lightened by ~30%
  static const shadowColor = Color(0xFF9A9393);
  static const subHeaderNotTaken = Color(0xFFD42A2A);
  static const borderColor = Color(0XFF9A9393);
  static const customGrey = Color(0XFFf6f6f9);
  static const warningColor = Color(0XFFFD9900);
  static const flintColor = Color(0XFF666666);

  // on boarding background Color
  static const bgScreen1 = Color(0XFF548AD8);
  static const bgScreen2 = Color(0XFFF33E62);
  static const bgScreen3 = Color(0XFFF79334);

  // currculum page
  static const LinearGradient quranColor = LinearGradient(colors: [
    Color(0xFFD39646),
    Color.fromARGB(127, 228, 156, 63),
  ]);
  static const LinearGradient islamicColor = LinearGradient(colors: [
    Color(0xFF88A2C4),
    Color(0XFF475492),
  ]);
  static const LinearGradient arabicColor = LinearGradient(colors: [
    Color(0xFF68A0A6),
    Color(0XFFA7CBD9),
  ]);
  static const LinearGradient englisColor = LinearGradient(colors: [
    Color(0xFF74A892),
    Color(0XFF008585),
  ]);
  static const LinearGradient chemistyColor = LinearGradient(colors: [
    Color(0xFFF79334),
    Color(0XFFF33E62),
  ]);
  static const LinearGradient physicsColor = LinearGradient(colors: [
    Color(0xFF893E9C),
    Color(0XFFF82B73),
  ]);
  static const LinearGradient biologyColor = LinearGradient(colors: [
    Color(0xFF007F4E),
    Color(0XFF72B043),
  ]);
  static const LinearGradient mathColor = LinearGradient(colors: [
    Color(0xFF548AD8),
    Color(0XFF8A4BD3),
  ]);
  static const LinearGradient socialStudiesColor = LinearGradient(colors: [
    Color(0xFFF7910F),
    Color(0XFFA33162),
  ]);

  static const LinearGradient aboutUsViewsBorderColor_1 = LinearGradient(
    colors: [
      Color(0xFFf52c74),
      Color(0xFFce3383),
      Color(0xFF903d9a),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient aboutUsViewsBorderColor_2 = LinearGradient(
    colors: [
      Color(0xFF5589d8),
      Color(0xFF6972d6),
      Color(0xFF894dd3),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient aboutUsViewsBorderColor_3 = LinearGradient(
    colors: [
      Color(0xFFf79135),
      Color(0xFFf56c49),
      Color(0xFFf34061),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient aboutUsViewsBorderColor_4 = LinearGradient(
    colors: [
      Color(0xFF86a0c3),
      Color(0xFF6a7ead),
      Color(0xFF485693),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient aboutUsViewsBorderColor_5 = LinearGradient(
    colors: [
      Color(0xFF33d9b2),
      Color(0xFF10ac84),
      Color(0xFF1dd1a1),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

final OutlineInputBorder baseBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: const BorderSide(
    color: AppColors.mainColor,
    width: 2, // Adjusted for a more balanced UI
  ),
);

/// Light theme data
final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightenMainColor,
  primaryColor: AppColors.lightenMainColor,
  fontFamily: 'ElMessiri',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.mainColor, // Default color
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.mainColor,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.mainColor,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.mainColor,
    ),
    titleMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.mainColor,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.mainColor,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    // labelText: labelText,
    labelStyle: const TextStyle(fontSize: 16, color: AppColors.hintColor),
    // errorText: errorMessage,
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 16,
    ),
    border: baseBorder,
    enabledBorder: baseBorder,
    focusedBorder: baseBorder.copyWith(
      borderSide: const BorderSide(
        color: AppColors.mainColor,
        width: 3, // Slightly thicker on focus
      ),
    ),
    errorBorder: baseBorder.copyWith(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
    focusedErrorBorder: baseBorder.copyWith(
      borderSide: const BorderSide(
        color: Colors.redAccent,
        width: 3,
      ),
    ),
    // prefixIcon: prefixIcon,
    prefixIconColor: AppColors.mainColor,
    suffixIconColor: AppColors.mainColor,
  ),
  iconTheme: const IconThemeData(color: AppColors.mainColor, size: 24),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStateProperty.all(24),
      iconColor: WidgetStateProperty.all(AppColors.mainColor),
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.moreLightenMainColor,
    secondary: AppColors.mainColor,
    surface: AppColors.darkMainColor,
    // Background in light mode
  ),
  cardTheme: const CardTheme(
    color: AppColors.moreLightenMainColor,
    elevation: 10,
    shadowColor: AppColors.darkMainColor,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.mainColor,
    textColor: AppColors.lightenMainColor,
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: AppColors.mainColor),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none, // Removes border for DropdownButtonFormField
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    ),
    menuStyle: MenuStyle(
      side: WidgetStateProperty.all(BorderSide.none),
      backgroundColor: WidgetStateProperty.all(AppColors.moreLightenMainColor),
    ),
  ),
  switchTheme: SwitchThemeData(
    trackOutlineColor:
        WidgetStateProperty.all(Colors.transparent), // Remove track border
  ),
);

/// -------------  Dark theme -----------------
final ThemeData darkAppTheme = ThemeData(
  primaryColor: AppColors.mainColor,
  fontFamily: 'ElMessiri',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.lightenMainColor, // Default color
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.lightenMainColor,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.lightenMainColor,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.lightenMainColor,
    ),
    titleMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.lightenMainColor,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.lightenMainColor,
    ),
  ),
  scaffoldBackgroundColor: AppColors.darkMainColor,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    isDense: true,
    alignLabelWithHint: true,
    fillColor: AppColors.mainColor,
    labelStyle: const TextStyle(fontSize: 16, color: AppColors.hintColor),
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 16,
    ),
    border: baseBorder,
    enabledBorder: baseBorder,
    focusedBorder: baseBorder.copyWith(
      borderSide: const BorderSide(
        color: AppColors.mainColor,
        width: 3, // Slightly thicker on focus
      ),
    ),
    errorBorder: baseBorder.copyWith(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
    focusedErrorBorder: baseBorder.copyWith(
      borderSide: const BorderSide(
        color: Colors.redAccent,
        width: 3,
      ),
    ),
    hintStyle:
        const TextStyle(fontSize: 16, color: AppColors.hintColor, height: 2),
    // prefixIcon: prefixIcon,
    prefixIconColor: AppColors.lightenMainColor,
    suffixIconColor: AppColors.lightenMainColor,
  ),
  iconTheme: const IconThemeData(color: AppColors.lightenMainColor, size: 24),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStateProperty.all(24),
      iconColor: WidgetStateProperty.all(AppColors.lightenMainColor),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.mainColor,
    secondary: AppColors.lightenMainColor,
    surface: AppColors.mainColor,

    // Background in light mode
  ),
  cardTheme: const CardTheme(
    color: AppColors.mainColor,
    elevation: 10,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.lightenMainColor,
    textColor: AppColors.lightenMainColor,
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: AppColors.lightenMainColor),
  switchTheme: SwitchThemeData(
    trackOutlineColor:
        WidgetStateProperty.all(Colors.transparent), // Remove track border
  ),
);
