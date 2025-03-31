import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/data/models/models.dart';

class BreakRecommendationWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;
  final List<RecommendationItem> recommendations;

  const BreakRecommendationWidget({
    super.key,
    required this.title,
    this.onSeeAllTap,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            if (onSeeAllTap != null)
              GestureDetector(
                onTap: onSeeAllTap,
                child: Text(
                  'See all',
                  style: AppTextStyle.satoshi(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: recommendations.map((recommendation) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.only(right: 16.w),
                child: GlassyContainer(
                  backgroundColor: Colors.white,
                  borderColor: Colors.white,
                  padding: EdgeInsets.all(16.r),
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
          ),
        ),
      ],
    );
  }
} 