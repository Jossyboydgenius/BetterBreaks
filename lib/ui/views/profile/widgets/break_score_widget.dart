import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class BreakScoreWidget extends StatelessWidget {
  final VoidCallback onTap;

  const BreakScoreWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: GlassyContainer(
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with icon and chevron
              Row(
                children: [
                  // Work icon in circle
                  Container(
                    width: 42.r,
                    height: 42.r,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AppIcons(
                        icon: AppIconData.work,
                        size: 24.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Break score',
                    style: AppTextStyle.raleway(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  Spacer(),
                  AppIcons(
                    icon: AppIconData.rightArrow,
                    size: 14.r,
                    color: AppColors.grey800,
                  ),
                ],
              ),

              // Divider
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),

              // Score display - using the style from break analysis
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppIcons(
                    icon: AppIconData.zapFilled,
                    size: 24.r,
                    color: AppColors.orange100,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '10',
                    style: AppTextStyle.raleway(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  Text(
                    '/100',
                    style: AppTextStyle.raleway(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Motivational text
              Text(
                'You are acing this!',
                style: AppTextStyle.raleway(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'You have levelled up. Unlock more badges to keep that score soaring',
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
