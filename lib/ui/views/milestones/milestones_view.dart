import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/views/profile/widgets/break_score_widget.dart';

class MilestonesView extends StatelessWidget {
  const MilestonesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar
          _buildTopBar(context),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Break Score Widget - without circular container
                  BreakScoreWidget(
                    useCircularContainer: true,
                  ),

                  SizedBox(height: 16.h),

                  // Streak Widget
                  _buildStreakWidget(),

                  // Add more badge widgets or other content below
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppIcons(
              icon: AppIconData.back,
              size: 16.r,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // Title
          Text(
            'Milestones & Badges',
            style: AppTextStyle.raleway(
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakWidget() {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with lightning icon
          Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppIcons(
                    icon: AppIconData.zap,
                    size: 24.r,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                'Streak',
                style: AppTextStyle.raleway(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Description text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              'Use your recommended holiday this month to maintain a perfect streak',
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlack,
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withOpacity(0.5),
          ),

          SizedBox(height: 24.h),

          // Streak months with stacked bolt image
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Stacked bolt image (using your app image data)
                Opacity(
                  opacity: 0.3,
                  child: SizedBox(
                    height: 150.h,
                    width: double.infinity,
                    child: AppImages(
                      imagePath: AppImageData.stackBolt,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Text overlay
                Text(
                  '6 Months\nStreaks!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.raleway(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
