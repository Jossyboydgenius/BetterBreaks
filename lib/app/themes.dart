import 'package:flutter/material.dart';

class AppTheme {
  // Define font families as constants
  static const String ralewayFont = "Raleway";
  static const String redRoseFont = "RedRose";
  static const String satoshiFont = "Satoshi";

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: ralewayFont, // Set Raleway as default font
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.white,
    ),
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
}