import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class BreakScoreWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final bool useCircularContainer;

  const BreakScoreWidget({
    super.key,
    this.onTap,
    this.useCircularContainer = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassyContainer(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Break score header
            Row(
              children: [
                // Work icon in circle
                Container(
                  width: 48.r,
                  height: 48.r,
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
                Expanded(
                  child: Text(
                    'Break score',
                    style: AppTextStyle.raleway(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ),
                AppIcons(
                  icon: AppIconData.rightArrow,
                  size: 14.r,
                  color: AppColors.grey800,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Break score in a row with lightning icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Lightning icon
                Container(
                  width: useCircularContainer ? 36.r : null,
                  height: useCircularContainer ? 36.r : null,
                  decoration: useCircularContainer
                      ? BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        )
                      : null,
                  padding: useCircularContainer ? EdgeInsets.all(6.r) : null,
                  child: AppIcons(
                    icon: AppIconData.zapFilled,
                    size: 24.r,
                  ),
                ),
                SizedBox(width: 12.w),
                // Score
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '10',
                        style: AppTextStyle.raleway(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      TextSpan(
                        text: '/100',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

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
    );
  }
}
