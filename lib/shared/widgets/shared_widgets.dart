// Export file for all shared widgets
export '../../ui/widgets/glassy_container.dart';
export '../widgets/app_dots_indicator.dart';
export '../../ui/widgets/break_analysis_slider.dart';

import 'package:flutter/material.dart';
import 'dart:ui';

class GlassyContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final double blurSigmaX;
  final double blurSigmaY;
  final BorderRadius borderRadius;
  
  const GlassyContainer({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
    this.padding,
    this.blurSigmaX = 10.0,
    this.blurSigmaY = 10.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.45),
            border: Border.all(
              color: borderColor.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: borderRadius,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
} 