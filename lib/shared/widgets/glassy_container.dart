import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class GlassyContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blurSigmaX;
  final double blurSigmaY;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;

  const GlassyContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 16.0,
    this.blurSigmaX = 10.0,
    this.blurSigmaY = 10.0,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(
          color: borderColor.withOpacity(0.5),
          width: borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.45),
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
} 