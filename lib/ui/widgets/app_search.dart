import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';

class AppSearch extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onFilterTap;
  final String placeholder;

  const AppSearch({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterTap,
    this.placeholder = 'Search',
  });

  @override
  Widget build(BuildContext context) {
    final Color textAndIconColor = AppThemeColors.getTextColor(context);

    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppThemeColors.getCardColor(context).withOpacity(0.45),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          // Search icon
          AppIcons(
            icon: AppIconData.search,
            size: 20.r,
            color: textAndIconColor,
          ),
          SizedBox(width: 12.w),

          // Search text field
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyle.satoshi(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: textAndIconColor,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: AppTextStyle.satoshi(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: textAndIconColor.withOpacity(0.7),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // Vertical divider
          Container(
            height: 20.h,
            width: 1,
            color: textAndIconColor,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
          ),

          // Filter icon
          GestureDetector(
            onTap: onFilterTap,
            child: AppIcons(
              icon: AppIconData.filter,
              size: 20.r,
              color: textAndIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
