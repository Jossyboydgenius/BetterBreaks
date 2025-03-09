import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class AppRadioButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const AppRadioButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 24.r,
            height: 24.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: isSelected ? AppColors.primaryLight : Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.primaryLight : AppColors.grey,
                width: 1,
              ),
            ),
            child: isSelected
                ? Center(
                    child: AppIcons(
                      icon: AppIconData.check,
                      size: 12.r,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: AppTextStyle.satoshiRegular20.copyWith(
              fontSize: 16.sp,
              color: AppColors.lightBlack,
            ),
          ),
        ],
      ),
    );
  }
} 