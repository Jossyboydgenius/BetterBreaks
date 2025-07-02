import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';

class RecommendationCard extends StatelessWidget {
  final String dateRange;
  final String description;
  final bool isHighImpact;
  final List<String> holidays;
  final VoidCallback onPreviewTap;

  const RecommendationCard({
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
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppThemeColors.getCardColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppThemeColors.getDividerColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBadge(
            text: isHighImpact ? 'High Impact' : 'Low Impact',
            backgroundColor:
                isHighImpact ? AppColors.bgRed100 : AppColors.lightGreen100,
            textColor: isHighImpact ? AppColors.red100 : AppColors.green,
          ),
          SizedBox(height: 12.h),
          Text(
            dateRange,
            style: AppTextStyle.raleway(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppThemeColors.getTextColor(context),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppThemeColors.getSecondaryTextColor(context),
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: holidays
                .map((holiday) =>
                    AppBadge.holidayThemed(text: holiday, context: context))
                .toList(),
          ),
          SizedBox(height: 12.h),
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
