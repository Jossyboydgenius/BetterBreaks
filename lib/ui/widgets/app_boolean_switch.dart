import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class AppBooleanSwitch extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppBooleanSwitch({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          SizedBox(
            width: 51.w, // Match Figma width
            height: 31.h, // Match Figma height
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white, // White toggle circle when active
              activeTrackColor: AppColors.primaryLight, // Primary light background when active
              inactiveThumbColor: Colors.white, // White toggle circle when inactive
              inactiveTrackColor: AppColors.grey, // White background when inactive
              trackOutlineColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.primaryLight; // Border color when active
                  }
                  return AppColors.grey; // Border color when inactive
                },
              ),
              trackOutlineWidth: MaterialStateProperty.all(1.0), // Border width
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
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