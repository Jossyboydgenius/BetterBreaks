import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';

class SuggestionCard extends StatelessWidget {
  final String dateRange;
  final String description;
  final bool isHighImpact;
  final List<String> holidays;
  final VoidCallback onPreviewTap;

  const SuggestionCard({
    super.key,
    required this.dateRange,
    required this.description,
    required this.isHighImpact,
    required this.holidays,
    required this.onPreviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34.r),
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBadge(
            text: isHighImpact ? 'High Impact' : 'Low Impact',
            backgroundColor: isHighImpact ? AppColors.bgRed100 : AppColors.lightGreen100,
            textColor: isHighImpact ? AppColors.red100 : AppColors.green,
          ),
          SizedBox(height: 12.h),
          Text(
            dateRange,
            style: AppTextStyle.raleway(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: holidays
                .map((holiday) => AppBadge.holiday(text: holiday))
                .toList(),
          ),
          SizedBox(height: 16.h),
          AppButton(
            text: 'Preview',
            backgroundColor: AppColors.primary,
            onPressed: onPreviewTap,
            height: 44.h,
          ),
        ],
      ),
    );
  }
}