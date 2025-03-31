import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/data/models/models.dart';

class AllRecommendationsView extends StatelessWidget {
  final List<RecommendationItem> recommendations;

  const AllRecommendationsView({
    super.key,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: recommendations.map((recommendation) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: GlassyContainer(
            backgroundColor: Colors.white,
            borderColor: Colors.white,
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: recommendation.isHighImpact ? AppColors.bgRed100 : AppColors.lightGreen100,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: Text(
                    recommendation.isHighImpact ? 'High Impact' : 'Low Impact',
                    style: AppTextStyle.satoshi(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: recommendation.isHighImpact ? AppColors.red100 : AppColors.green,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  recommendation.dateRange,
                  style: AppTextStyle.raleway(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  recommendation.description,
                  style: AppTextStyle.satoshi(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBlack100,
                  ),
                ),
                SizedBox(height: 16.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: recommendation.holidays
                      .map((holiday) => Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBE6),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        child: Text(
                          holiday,
                          style: AppTextStyle.satoshi(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFBBC04),
                          ),
                        ),
                      ))
                      .toList(),
                ),
                SizedBox(height: 20.h),
                AppButton(
                  text: 'Preview',
                  backgroundColor: AppColors.primary,
                  onPressed: recommendation.onPreviewTap,
                  height: 48.h,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
} 