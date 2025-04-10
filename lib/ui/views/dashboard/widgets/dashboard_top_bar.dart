import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';

class DashboardTopBar extends StatelessWidget {
  final bool showAllRecommendations;
  final bool showAllBreaks;
  final VoidCallback onBackPressed;

  const DashboardTopBar({
    super.key,
    required this.showAllRecommendations,
    required this.showAllBreaks,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppBackButton(
                  color: Colors.white,
                  onPressed: onBackPressed,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Better Breaks, Better You',
              style: AppTextStyle.raleway(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              showAllRecommendations
                  ? 'Here are our optimised Recommendations'
                  : showAllBreaks
                      ? 'All Upcoming Breaks'
                      : '',
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
