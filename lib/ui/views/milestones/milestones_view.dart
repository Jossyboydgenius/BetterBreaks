import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
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
          Text(
            'Use your recommended holiday this month to maintain a perfect streak',
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack,
            ),
          ),

          SizedBox(height: 24.h),

          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withOpacity(0.5),
          ),

          SizedBox(height: 16.h),

          // Streak months with lightning bolts
          SizedBox(
            width: double.infinity,
            height: 140.h, // Adjusted height to match screenshot better
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Lightning bolt pattern (around the text)
                _buildLightningBoltPattern(),

                // Text overlay (in the center)
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      '6 Months\nStreaks!',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.raleway(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Description below the streak display
          SizedBox(height: 16.h),
          Text(
            "You've been scheduling breaks for 6 months straight. Keep it up!",
            textAlign: TextAlign.center,
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLightningBoltPattern() {
    // Create a circular arrangement of lightning bolts
    return Stack(
      children: [
        // Top row
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              7,
              (index) => AppIcons(
                icon: AppIconData.zapFilled,
                size: 24.r,
                color: AppColors.amber.withOpacity(0.3),
              ),
            ),
          ),
        ),

        // Left side
        Positioned(
          top: 30.h,
          left: 0,
          bottom: 30.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => AppIcons(
                icon: AppIconData.zapFilled,
                size: 24.r,
                color: AppColors.amber.withOpacity(0.3),
              ),
            ),
          ),
        ),

        // Right side
        Positioned(
          top: 30.h,
          right: 0,
          bottom: 30.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => AppIcons(
                icon: AppIconData.zapFilled,
                size: 24.r,
                color: AppColors.amber.withOpacity(0.3),
              ),
            ),
          ),
        ),

        // Bottom row
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              7,
              (index) => AppIcons(
                icon: AppIconData.zapFilled,
                size: 24.r,
                color: AppColors.amber.withOpacity(0.3),
              ),
            ),
          ),
        ),

        // Top-left corner
        Positioned(
          top: 20.h,
          left: 20.w,
          child: AppIcons(
            icon: AppIconData.zapFilled,
            size: 24.r,
            color: AppColors.amber.withOpacity(0.3),
          ),
        ),

        // Top-right corner
        Positioned(
          top: 20.h,
          right: 20.w,
          child: AppIcons(
            icon: AppIconData.zapFilled,
            size: 24.r,
            color: AppColors.amber.withOpacity(0.3),
          ),
        ),

        // Bottom-left corner
        Positioned(
          bottom: 20.h,
          left: 20.w,
          child: AppIcons(
            icon: AppIconData.zapFilled,
            size: 24.r,
            color: AppColors.amber.withOpacity(0.3),
          ),
        ),

        // Bottom-right corner
        Positioned(
          bottom: 20.h,
          right: 20.w,
          child: AppIcons(
            icon: AppIconData.zapFilled,
            size: 24.r,
            color: AppColors.amber.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}
