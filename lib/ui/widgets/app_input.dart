import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isDropdown;
  final String? icon;
  final VoidCallback? onTap;
  final bool readOnly;

  const AppInput({
    super.key,
    required this.hintText,
    this.controller,
    this.isDropdown = false,
    this.icon,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: readOnly,
                style: AppTextStyle.satoshiRegular20.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.lightBlack,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppTextStyle.satoshiRegular20.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.grey600,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (icon != null)
              AppIcons(
                icon: icon!,
                size: 24.r,
                color: AppColors.grey600,
              ),
            if (isDropdown)
              AppIcons(
                icon: AppIconData.chevronDown,
                size: 24.r,
                color: AppColors.grey600,
              ),
          ],
        ),
      ),
    );
  }
} 