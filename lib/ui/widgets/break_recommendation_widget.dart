import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';

class BreakRecommendationWidget extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;
  final List<RecommendationItem> recommendations;
  
  const BreakRecommendationWidget({
    Key? key,
    required this.title,
    required this.onSeeAllTap,
    required this.recommendations,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lightBlack,
              ),
            ),
            TextButton(
              onPressed: onSeeAllTap,
              child: Text(
                'See all',
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 240.h,  // Increased height to prevent overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              return _RecommendationCard(
                dateRange: recommendations[index].dateRange,
                description: recommendations[index].description,
                isHighImpact: recommendations[index].isHighImpact,
                holidays: recommendations[index].holidays,
                onPreviewTap: recommendations[index].onPreviewTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecommendationItem {
  final String dateRange;
  final String description;
  final bool isHighImpact;
  final List<String> holidays;
  final VoidCallback onPreviewTap;

  const RecommendationItem({
    required this.dateRange,
    required this.description,
    required this.isHighImpact,
    required this.holidays,
    required this.onPreviewTap,
  });
}

class _RecommendationCard extends StatelessWidget {
  final String dateRange;
  final String description;
  final bool isHighImpact;
  final List<String> holidays;
  final VoidCallback onPreviewTap;

  const _RecommendationCard({
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
      height: 240.h, // Fixed height to ensure consistency across devices
      margin: EdgeInsets.only(right: 16.w),
      child: GlassyContainer(
        padding: EdgeInsets.all(16.r),
        backgroundColor: Colors.white,
        borderColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBadge(
              text: isHighImpact ? 'High Impact' : 'Low Impact',
              backgroundColor: isHighImpact ? AppColors.bgRed100 : AppColors.lightGreen100,
              textColor: isHighImpact ? AppColors.red100 : AppColors.green,
            ),
            SizedBox(height: 4.h),
            Text(
              dateRange,
              style: AppTextStyle.raleway(
                fontSize: 22.sp,
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
            Spacer(),
            AppButton(
              text: 'Preview',
              backgroundColor: AppColors.primary,
              onPressed: onPreviewTap,
              height: 44.h,
            ),
            SizedBox(height: 8.h), // Add bottom padding to prevent button from touching the edge
          ],
        ),
      ),
    );
  }
} 