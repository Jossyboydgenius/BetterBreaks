import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String icon;
  final Widget? trailing;
  final Color? iconBackgroundColor;

  const SectionHeader({
    super.key,
    required this.title,
    required this.icon,
    this.trailing,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon in circle
        Container(
          width: 42.r,
          height: 42.r,
          decoration: BoxDecoration(
            color: iconBackgroundColor ?? AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AppIcons(
              icon: icon,
              size: 24.r,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          title,
          style: AppTextStyle.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppThemeColors.getTextColor(context),
          ),
        ),
        if (trailing != null) ...[
          const Spacer(),
          trailing!,
        ],
      ],
    );
  }
}
