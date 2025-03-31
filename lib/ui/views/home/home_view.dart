import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_top_bar.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/mood_check_in.dart';
import 'package:better_breaks/ui/widgets/break_recommendation_widget.dart';
import 'package:better_breaks/ui/widgets/optimization_timeline_widget.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'dart:ui';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:better_breaks/ui/widgets/setup_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  final bool setupCompleted;
  
  const HomeView({
    super.key, 
    this.setupCompleted = false
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavIndex = 0; // 0: Dashboard, 1: Plan, 2: Experience, 3: Analytics
  double _moodValue = 2; // Initial mood (expressionless)
  late bool _setupCompleted; // Track if setup is completed

  @override
  void initState() {
    super.initState();
    _setupCompleted = widget.setupCompleted; // Initialize from the widget parameter
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              AppTopBar(
                heading: 'BetterBreaks',
                headingFontSize: 16,
                subheading: 'Serah Lopez',
                subheadingFontSize: 24,
                subheadingFontWeight: FontWeight.w700,
                icon: AppIconData.settings,
                iconSize: 46,
                onIconTap: () {
                  // Open settings
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _setupCompleted 
                          ? _buildCompletedSetupSection() 
                          : _buildLeavePreferenceSection(),
                      SizedBox(height: 24.h),
                      if (_setupCompleted) // Only show recommendations when setup is completed
                        BreakRecommendationWidget(
                          title: 'Breaks Recommendation',
                          onSeeAllTap: () {
                            // Navigate to see all recommendations
                          },
                          recommendations: [
                            RecommendationItem(
                              dateRange: 'December 27-29',
                              description: 'Take 3 days off to get 9 days of holiday',
                              isHighImpact: true,
                              holidays: ['Christmas', 'New year'],
                              onPreviewTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PlannerView(),
                                  ),
                                );
                              },
                            ),
                            RecommendationItem(
                              dateRange: 'January 15-18',
                              description: 'Take 3 days off to get 9 days of holiday',
                              isHighImpact: true,
                              holidays: ['Easter', 'Spring break'],
                              onPreviewTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PlannerView(),
                                  ),
                                );
                              },
                            ),
                            RecommendationItem(
                              dateRange: 'May 22-26',
                              description: 'Take 4 days off to get 9 days of holiday',
                              isHighImpact: false,
                              holidays: ['Memorial Day', 'Summer start'],
                              onPreviewTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PlannerView(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      if (_setupCompleted) // Add spacing only when needed
                        SizedBox(height: 24.h),
                      if (_setupCompleted) // Only show optimization timeline when setup is completed
                        OptimizationTimelineWidget(
                          title: 'Analytics',
                          onSeeAllTap: () {
                            // Navigate to analytics screen
                          },
                        ),
                      if (_setupCompleted) // Add spacing only when needed
                        SizedBox(height: 24.h),
                      MoodCheckIn(
                        onMoodSelected: (value) {
                          setState(() {
                            _moodValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Add bottom padding to accommodate the bottom nav
              SizedBox(height: 80.h),
            ],
          ),
          AppBottomNav(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedNavIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedSetupSection() {
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
                  iconData: AppIconData.calendar,
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

  Widget _buildLeavePreferenceSection() {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Are you making the most of your breaks?',
            style: AppTextStyle.raleway(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'How well you have planned your breaks',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          AppImages(
            imagePath: AppImageData.calendarPlan,
            width: 150.w,
            height: 150.h,
          ),
          SizedBox(height: 16.h),
          Text(
            'Set up your leave preference so you can see detailed analysis',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          AppButton(
            text: 'Set up',
            backgroundColor: AppColors.primary,
            onPressed: () {
              // Show setup bottomsheet
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                builder: (context) => SetupBottomSheet(
                  onComplete: () {
                    Navigator.pop(context); // Close the bottom sheet
                    setState(() {
                      _setupCompleted = true; // Mark setup as completed
                    });
                  },
                ),
              );
            },
            height: 44.h,
          ),
        ],
      ),
    );
  }
}

// Custom thumb shape for slider
class RoundedRectangleThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;

  const RoundedRectangleThumbShape({
    required this.enabledThumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw drop shadow
    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: enabledThumbRadius)),
      Colors.black.withOpacity(0.2),
      4,
      true,
    );

    // Draw white circle
    canvas.drawCircle(center, enabledThumbRadius, fillPaint);
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);
  }
} 