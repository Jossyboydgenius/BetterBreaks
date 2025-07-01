import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';

class AppTheme {
  // Define font families as constants
  static const String ralewayFont = "Raleway";
  static const String redRoseFont = "RedRose";
  static const String satoshiFont = "Satoshi";
  static const String playFont = "Play";
  static const String interVariableFont = "Inter-Variable";

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: ralewayFont, // Set Raleway as default font
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      background: AppColors.background,
      surface: Colors.white,
      onSurface: AppColors.lightBlack,
      onBackground: AppColors.lightBlack,
    ),
    cardColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
    ),
    dialogBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      // Define default text styles with specific fonts
      displayLarge: TextStyle(fontFamily: redRoseFont),
      displayMedium: TextStyle(fontFamily: redRoseFont),
      displaySmall: TextStyle(fontFamily: redRoseFont),

      headlineLarge: TextStyle(fontFamily: ralewayFont),
      headlineMedium: TextStyle(fontFamily: ralewayFont),
      headlineSmall: TextStyle(fontFamily: ralewayFont),

      bodyLarge: TextStyle(fontFamily: satoshiFont),
      bodyMedium: TextStyle(fontFamily: satoshiFont),
      bodySmall: TextStyle(fontFamily: satoshiFont),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark,
    fontFamily: ralewayFont,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      background: AppColors.backgroundDark,
      surface: AppColors.lightBlack,
      onSurface: Colors.white,
      onBackground: Colors.white,
      brightness: Brightness.dark,
    ),
    cardColor: AppColors.lightBlack,
    dialogBackgroundColor: AppColors.lightBlack,
    bottomSheetTheme: BottomSheetThemeData(
      surfaceTintColor: AppColors.lightBlack,
      backgroundColor: AppColors.lightBlack,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: redRoseFont, color: Colors.white),
      displayMedium: TextStyle(fontFamily: redRoseFont, color: Colors.white),
      displaySmall: TextStyle(fontFamily: redRoseFont, color: Colors.white),
      headlineLarge: TextStyle(fontFamily: ralewayFont, color: Colors.white),
      headlineMedium: TextStyle(fontFamily: ralewayFont, color: Colors.white),
      headlineSmall: TextStyle(fontFamily: ralewayFont, color: Colors.white),
      bodyLarge: TextStyle(fontFamily: satoshiFont, color: Colors.white),
      bodyMedium: TextStyle(fontFamily: satoshiFont, color: Colors.white),
      bodySmall: TextStyle(fontFamily: satoshiFont, color: Colors.white),
    ),
  );
}
