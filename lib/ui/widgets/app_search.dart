import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

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
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Search icon
          AppIcons(
            icon: AppIconData.search,
            size: 20.r,
            color: Colors.white,
          ),
          SizedBox(width: 12.w),

          // Search text field
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.7),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // Vertical divider
          Container(
            height: 24.h,
            width: 1,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
          ),

          // Filter icon
          GestureDetector(
            onTap: onFilterTap,
            child: AppIcons(
              icon: AppIconData.filter,
              size: 20.r,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
