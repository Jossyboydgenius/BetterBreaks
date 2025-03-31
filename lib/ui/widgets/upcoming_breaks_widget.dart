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
      return _buildBreakDetailCard(context, breaks.first);
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
            children: breaks.map((breakItem) => _buildBreakCard(context, breakItem)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBreakCard(BuildContext context, BreakItem breakItem) {
    // Use fixed sizes based on device width for consistency
    final screenWidth = MediaQuery.of(context).size.width;
    final dateContainerWidth = screenWidth * 0.15; // 15% of screen width
    final dateContainerHeight = dateContainerWidth * 1.2; // Aspect ratio of 1.2
    
    Widget card = Container(
      margin: EdgeInsets.only(bottom: breakItem == breaks.last ? 0 : 8.h),
      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date container with fixed dimensions
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
          
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.r),
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

  Widget _buildBreakDetailCard(BuildContext context, BreakItem breakItem) {
    // Use fixed sizes based on device width for consistency
    final screenWidth = MediaQuery.of(context).size.width;
    final dateContainerWidth = screenWidth * 0.18; // 18% of screen width
    final dateContainerHeight = dateContainerWidth * 1.2; // Aspect ratio of 1.2
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Date container with fixed dimensions
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
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    breakItem.day,
                    style: AppTextStyle.raleway(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Title and info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    breakItem.title,
                    style: AppTextStyle.raleway(
                      fontSize: 18.sp,
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
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 8.h),
                  AppBadge(
                    text: 'In ${breakItem.daysRemaining} days',
                    backgroundColor: breakItem.cardColor.withOpacity(0.2),
                    textColor: breakItem.cardColor,
                    isSmall: false,
                  ),
                ],
              ),
            ),
          ],
        ),
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