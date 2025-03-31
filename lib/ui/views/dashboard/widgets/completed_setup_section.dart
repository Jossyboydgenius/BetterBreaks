import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';

class CompletedSetupSection extends StatelessWidget {
  const CompletedSetupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you making the most of your breaks?',
            style: AppTextStyle.raleway(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'How well you have planned your leave',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
          ),
          SizedBox(height: 24.h),
          
          // Break Analysis Slider
          const BreakAnalysisSlider(),
          
          SizedBox(height: 32.h),
          
          // Stats row - make horizontally scrollable
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                AppStatCard(
                  title: 'Total Days',
                  value: '25 Days',
                  iconData: AppIconData.calendar,
                  color: AppColors.orange100,
                  width: 140,
                ),
                SizedBox(width: 8.w),
                AppStatCard(
                  title: 'Break Used',
                  value: '12 Days',
                  iconData: AppIconData.sidebarTop01,
                  color: AppColors.lightGreen,
                  width: 140,
                ),
                SizedBox(width: 8.w),
                AppStatCard(
                  title: 'Days Left',
                  value: '25 Days',
                  iconData: AppIconData.sunny,
                  color: AppColors.lightBlue,
                  width: 140,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 