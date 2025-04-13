import 'dart:math';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class AppCircularProgress extends StatelessWidget {
  /// The progress value (0.0 to 1.0)
  final double progress;

  /// Primary label to display in the center
  final String primaryLabel;

  /// Optional secondary label to display below primary label
  final String secondaryLabel;

  /// Optional icon to display before primary label
  final IconData? iconData;

  /// Optional icon to display (as string path for AppIcons)
  final String? iconPath;

  /// Primary color for the progress arc
  final Color progressColor;

  /// Background color for the progress arc
  final Color backgroundColor;

  /// Width of the progress arc
  final double strokeWidth;

  /// Optional text for max value (like "/100")
  final String? maxValueText;

  const AppCircularProgress({
    super.key,
    required this.progress,
    required this.primaryLabel,
    required this.secondaryLabel,
    this.iconData,
    this.iconPath,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.strokeWidth = 12.0,
    this.maxValueText,
  });

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final containerSize = screenWidth * 0.62; // 62% of screen width

    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(
          containerSize * 0.06), // Reduced padding to make content larger
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(containerSize * 0.88,
                containerSize * 0.88), // Increased proportion of container
            painter: CircleProgressPainter(
              progress: progress,
              progressColor: progressColor,
              backgroundColor: progressColor.withOpacity(0.2),
              activeStrokeWidth: strokeWidth * 1.8,
              inactiveStrokeWidth: strokeWidth * 0.8,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (iconData != null || iconPath != null) ...[
                    Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: iconPath != null
                          ? AppIcons(
                              icon: iconPath!,
                              size: 25.r,
                              color: progressColor,
                            )
                          : Icon(iconData, color: progressColor, size: 25.r),
                    ),
                  ],
                  Text(
                    primaryLabel,
                    style: AppTextStyle.raleway(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  if (maxValueText != null) ...[
                    Text(
                      maxValueText!,
                      style: AppTextStyle.raleway(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                secondaryLabel,
                textAlign: TextAlign.center,
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double activeStrokeWidth;
  final double inactiveStrokeWidth;

  CircleProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.activeStrokeWidth,
    required this.inactiveStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - activeStrokeWidth) / 2;

    // Background circle (thinner)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = inactiveStrokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc (wider)
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = activeStrokeWidth
      ..strokeCap = StrokeCap.round;

    final progressAngle = 2 * pi * progress; // Convert to radians

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top (minus pi/2)
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.activeStrokeWidth != activeStrokeWidth ||
        oldDelegate.inactiveStrokeWidth != inactiveStrokeWidth;
  }
}
