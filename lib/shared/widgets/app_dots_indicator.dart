import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:better_breaks/shared/app_colors.dart';

class AppDotsIndicator extends StatelessWidget {
  /// Total number of dots to display
  final int dotsCount;
  
  /// Current position/index (0-based)
  final int position;
  
  /// Color of the active dot
  final Color? activeColor;
  
  /// Color of inactive dots
  final Color? inactiveColor;
  
  /// Size of dots
  final double? dotSize;
  
  /// Size of the active dot (if different from dotSize)
  final double? activeDotSize;
  
  /// Spacing between dots
  final EdgeInsets? spacing;

  const AppDotsIndicator({
    Key? key,
    required this.dotsCount,
    required this.position,
    this.activeColor,
    this.inactiveColor,
    this.dotSize,
    this.activeDotSize,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: dotsCount,
      position: position,
      decorator: DotsDecorator(
        activeColor: activeColor ?? AppColors.primary,
        color: inactiveColor ?? Colors.white,
        size: Size(dotSize ?? 8.r, dotSize ?? 8.r),
        activeSize: Size(activeDotSize ?? dotSize ?? 8.r, activeDotSize ?? dotSize ?? 8.r),
        spacing: spacing ?? EdgeInsets.symmetric(horizontal: 4.w),
      ),
    );
  }
} 