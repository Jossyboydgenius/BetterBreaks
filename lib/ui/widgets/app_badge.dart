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

  factory AppBadge.holiday({required String name}) {
    switch (name.toLowerCase()) {
      case 'christmas':
        return AppBadge(
          text: 'Christmas',
          backgroundColor: AppColors.bgRed100,
          textColor: AppColors.red100,
          isSmall: true,
        );
      case 'new year':
        return AppBadge(
          text: 'New year',
          backgroundColor: AppColors.bgIndigo,
          textColor: AppColors.indigo,
          isSmall: true,
        );
      case 'el-fatir':
        return AppBadge(
          text: 'El-fatir',
          backgroundColor: AppColors.orange200,
          textColor: AppColors.orange100,
          isSmall: true,
        );
      case 'salah':
        return AppBadge(
          text: 'Salah',
          backgroundColor: AppColors.cream,
          textColor: AppColors.amber,
          isSmall: true,
        );
      default:
        return AppBadge(
          text: name,
          backgroundColor: AppColors.grey100,
          textColor: AppColors.grey600,
          isSmall: true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8.w : 12.w,
        vertical: isSmall ? 4.h : 6.h,
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
      ),
    );
  }
} 