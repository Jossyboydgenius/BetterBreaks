import 'package:better_breaks/data/models/break_models.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';

class UpcomingBreaksWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;
  final List<BreakItem> breaks;

  const UpcomingBreaksWidget({
    super.key,
    required this.title,
    this.onSeeAllTap,
    required this.breaks,
  });

  static Widget detailView({required BreakItem breakItem}) {
    return Builder(builder: (context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final dateContainerWidth = screenWidth * 0.2;
      final dateContainerHeight = dateContainerWidth * 1.2;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
        decoration: BoxDecoration(
          color: AppThemeColors.getCardColor(context),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.grey100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: dateContainerWidth,
              height: dateContainerHeight,
              decoration: BoxDecoration(
                color: breakItem.cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    breakItem.month,
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors
                          .white, // Keep white for good contrast on colored background
                    ),
                  ),
                  Text(
                    breakItem.day,
                    style: AppTextStyle.raleway(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors
                          .white, // Keep white for good contrast on colored background
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            breakItem.title,
                            style: AppTextStyle.raleway(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightBlack,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${breakItem.days} days • ${breakItem.status}',
                            style: AppTextStyle.satoshi(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    AppBadge(
                      text: 'In ${breakItem.daysRemaining} days',
                      backgroundColor: breakItem.cardColor.withOpacity(0.2),
                      textColor: breakItem.cardColor,
                      isSmall: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

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
        GlassyContainer(
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: breaks.take(3).map((breakItem) {
              final screenWidth = MediaQuery.of(context).size.width;
              final dateContainerWidth = screenWidth * 0.15;
              final dateContainerHeight = dateContainerWidth * 1.2;

              return Padding(
                padding:
                    EdgeInsets.only(bottom: breakItem == breaks.last ? 0 : 8.h),
                child: GestureDetector(
                  onTap: breakItem.onTap,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: dateContainerWidth,
                          height: dateContainerHeight,
                          decoration: BoxDecoration(
                            color: breakItem.cardColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                breakItem.month,
                                style: AppTextStyle.satoshi(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                breakItem.day,
                                style: AppTextStyle.raleway(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        breakItem.title,
                                        style: AppTextStyle.raleway(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.lightBlack,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        '${breakItem.days} days • ${breakItem.status}',
                                        style: AppTextStyle.satoshi(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                AppBadge(
                                  text: 'In ${breakItem.daysRemaining} days',
                                  backgroundColor:
                                      breakItem.cardColor.withOpacity(0.2),
                                  textColor: breakItem.cardColor,
                                  isSmall: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
