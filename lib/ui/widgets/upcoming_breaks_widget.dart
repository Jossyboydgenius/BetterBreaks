import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';

class UpcomingBreaksWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;
  final List<BreakItem> breaks;
  final bool isDetailView;

  const UpcomingBreaksWidget({
    super.key,
    this.title = 'Upcoming Breaks',
    this.onSeeAllTap,
    required this.breaks,
    this.isDetailView = false,
  });

  /// Creates a detail view of a single break
  factory UpcomingBreaksWidget.detailView({
    required BreakItem breakItem,
  }) {
    return UpcomingBreaksWidget(
      breaks: [breakItem],
      isDetailView: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isDetailView) {
      return _buildBreakDetailCard(breaks.first);
    }
    
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
            if (onSeeAllTap != null)
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
        GlassyContainer(
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: breaks.map((breakItem) => _buildBreakCard(breakItem)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBreakCard(BreakItem breakItem) {
    Widget card = Container(
      margin: EdgeInsets.only(bottom: breakItem == breaks.last ? 0 : 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Date container
              Container(
                width: 70.w,
                color: breakItem.cardColor,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      breakItem.month,
                      style: AppTextStyle.satoshi(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      breakItem.day,
                      style: AppTextStyle.raleway(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  color: Colors.white,
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
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${breakItem.days} days • ${breakItem.status}',
                              style: AppTextStyle.satoshi(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Days badge
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
        ),
      ),
    );
    
    // If onTap is provided, make the entire card tappable
    if (breakItem.onTap != null) {
      return GestureDetector(
        onTap: breakItem.onTap,
        child: card,
      );
    }
    
    return card;
  }

  Widget _buildBreakDetailCard(BreakItem breakItem) {
    return Container(
      height: 110.h,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Date container with rounded corners on the left side
              Container(
                width: 110.w,
                decoration: BoxDecoration(
                  color: breakItem.cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      breakItem.month,
                      style: AppTextStyle.satoshi(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      breakItem.day,
                      style: AppTextStyle.raleway(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r),
                    ),
                  ),
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        breakItem.title,
                        style: AppTextStyle.raleway(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${breakItem.days} days • ${breakItem.status}',
                        style: AppTextStyle.satoshi(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Days badge
          Positioned(
            top: 16.h,
            right: 16.w,
            child: AppBadge(
              text: 'In ${breakItem.daysRemaining} days',
              backgroundColor: breakItem.cardColor.withOpacity(0.2),
              textColor: breakItem.cardColor,
              isSmall: false,
            ),
          ),
        ],
      ),
    );
  }
}

class BreakItem {
  final String title;
  final String month;
  final String day;
  final int days;
  final String status;
  final int daysRemaining;
  final Color cardColor;
  final VoidCallback? onTap;

  const BreakItem({
    required this.title,
    required this.month,
    required this.day,
    required this.days,
    required this.status,
    required this.daysRemaining,
    required this.cardColor,
    this.onTap,
  });
} 