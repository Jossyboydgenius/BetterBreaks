import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class AppBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isSmall;

  const AppBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.isSmall = false,
  });

  factory AppBadge.highImpact() {
    return AppBadge(
      text: 'High Impact',
      backgroundColor: AppColors.bgRed100,
      textColor: AppColors.red100,
    );
  }

  factory AppBadge.lowImpact() {
    return AppBadge(
      text: 'Low Impact',
      backgroundColor: AppColors.lightGreen100,
      textColor: AppColors.green,
    );
  }

  factory AppBadge.holiday({
    required String text,
  }) {
    return AppBadge(
      text: text,
      backgroundColor: const Color(0xFFFFFBE6),
      textColor: const Color(0xFFFBB904),
    );
  }

  // New theme-aware holiday badge constructor
  static Widget holidayThemed({
    required String text,
    required BuildContext context,
  }) {
    // Light theme: use existing colors
    // Dark theme: use darker yellow background with brighter yellow text
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBadge(
      text: text,
      backgroundColor:
          isDark ? const Color(0xFF3D3A26) : const Color(0xFFFFFBE6),
      textColor: isDark ? const Color(0xFFFFD54F) : const Color(0xFFFBB904),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate constraints based on device width
    final deviceWidth = MediaQuery.of(context).size.width;
    final maxWidth = isSmall
        ? deviceWidth * 0.25
        : deviceWidth * 0.35; // 25% or 35% of screen width

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6.w : 10.w,
        vertical: isSmall ? 3.h : 5.h,
      ),
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: AppTextStyle.satoshi(
          fontSize: isSmall ? 10.sp : 12.sp,
          fontWeight: isSmall ? FontWeight.w500 : FontWeight.w400,
          color: textColor,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
