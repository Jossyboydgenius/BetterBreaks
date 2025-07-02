import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:better_breaks/shared/app_theme_colors.dart';

class GlassyContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double blurSigmaX;
  final double blurSigmaY;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const GlassyContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.blurSigmaX = 10.0,
    this.blurSigmaY = 10.0,
    this.borderRadius,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        backgroundColor ?? AppThemeColors.getCardColor(context);
    final Color borderCol = borderColor ?? bgColor;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        border: Border.all(
          color: borderCol.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: bgColor.withOpacity(0.45),
              borderRadius: borderRadius ?? BorderRadius.circular(16.r),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
