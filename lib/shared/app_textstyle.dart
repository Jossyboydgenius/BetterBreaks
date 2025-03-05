import 'package:flutter/material.dart';
import 'package:better_breaks/app/themes.dart';

abstract class AppTextStyle {
  // RedRose styles
  static TextStyle get redRoseBold32 => TextStyle(
    fontFamily: AppTheme.redRoseFont,
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
  );

  // Raleway styles
  static TextStyle get ralewayExtraBold48 => TextStyle(
    fontFamily: AppTheme.ralewayFont,
    fontSize: 48,
    fontWeight: AppFontWeight.extraBold,
  );

  // Satoshi styles
  static TextStyle get satoshiRegular20 => TextStyle(
    fontFamily: AppTheme.satoshiFont,
    fontSize: 20,
    fontWeight: AppFontWeight.regular,
  );

  // Helper methods for creating custom styles
  static TextStyle redRose({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) => TextStyle(
    fontFamily: AppTheme.redRoseFont,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle raleway({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) => TextStyle(
    fontFamily: AppTheme.ralewayFont,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle satoshi({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) => TextStyle(
    fontFamily: AppTheme.satoshiFont,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

abstract class AppFontWeight {
  /// FontWeight value of `w900`
  static const FontWeight black = FontWeight.w900;

  /// FontWeight value of `w800`
  static const FontWeight extraBold = FontWeight.w800;

  /// FontWeight value of `w700`
  static const FontWeight bold = FontWeight.w700;

  /// FontWeight value of `w600`
  static const FontWeight semiBold = FontWeight.w600;

  /// FontWeight value of `w500`
  static const FontWeight medium = FontWeight.w500;

  /// FontWeight value of `w400`
  static const FontWeight regular = FontWeight.w400;

  /// FontWeight value of `w300`
  static const FontWeight light = FontWeight.w300;

  /// FontWeight value of `w200`
  static const FontWeight extraLight = FontWeight.w200;

  /// FontWeight value of `w100`
  static const FontWeight thin = FontWeight.w100;
} 