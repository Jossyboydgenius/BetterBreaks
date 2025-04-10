import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class ExperienceTopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;

  const ExperienceTopBar({
    super.key,
    required this.title,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: MediaQuery.of(context).padding.top + 16.h,
          bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: onBackTap ?? () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: AppIcons(
                icon: AppIconData.back,
                size: 24.r,
                color: Colors.white,
              ),
            ),
          ),

          // Title
          Text(
            title,
            style: AppTextStyle.raleway(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
