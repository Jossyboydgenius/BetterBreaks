import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_top_bar.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/mood_check_in.dart';
import 'package:better_breaks/ui/widgets/break_recommendation_widget.dart';
import 'package:better_breaks/ui/widgets/optimization_timeline_widget.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'dart:ui';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:better_breaks/ui/widgets/setup_bottom_sheet.dart';
import 'package:better_breaks/ui/widgets/upcoming_breaks_widget.dart';
import 'package:better_breaks/ui/views/break_detail/break_detail_view.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';

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
  bool _showAllBreaks = false; // Track if showing all breaks view
  bool _showAllRecommendations = false; // Track if showing all recommendations view

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
              if (_showAllRecommendations)
                _buildRecommendationsTopBar()
              else
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
                  child: _showAllBreaks 
                    ? _buildAllBreaksView() 
                    : _showAllRecommendations 
                      ? _buildAllRecommendationsView()
                      : _buildHomeContent(),
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
                // Reset to home view when changing tabs
                if (_showAllBreaks || _showAllRecommendations) {
                  _showAllBreaks = false;
                  _showAllRecommendations = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsTopBar() {
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
                  onPressed: () {
                    setState(() {
                      _showAllRecommendations = false;
                    });
                  },
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
              'Here are our optimised Recommendations',
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

  Widget _buildHomeContent() {
    return Column(
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
              setState(() {
                _showAllRecommendations = true;
              });
            },
            recommendations: _getRecommendationsList(),
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
        if (_setupCompleted) // Only show upcoming breaks when setup is completed
          UpcomingBreaksWidget(
            title: 'Upcoming Breaks',
            onSeeAllTap: () {
              setState(() {
                _showAllBreaks = true;
              });
            },
            breaks: _getBreaksList(),
          ),
      ],
    );
  }

  Widget _buildAllRecommendationsView() {
    final recommendations = _getRecommendationsList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: recommendations.map((recommendation) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: GlassyContainer(
            backgroundColor: Colors.white,
            borderColor: Colors.white,
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Impact badge
                Container(
                  decoration: BoxDecoration(
                    color: recommendation.isHighImpact ? AppColors.bgRed100 : AppColors.lightGreen100,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: Text(
                    recommendation.isHighImpact ? 'High Impact' : 'Low Impact',
                    style: AppTextStyle.satoshi(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: recommendation.isHighImpact ? AppColors.red100 : AppColors.green,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // Date range
                Text(
                  recommendation.dateRange,
                  style: AppTextStyle.raleway(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                // Description
                Text(
                  recommendation.description,
                  style: AppTextStyle.satoshi(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBlack100,
                  ),
                ),
                SizedBox(height: 16.h),
                // Holiday badges
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: recommendation.holidays
                      .map((holiday) => Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBE6),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        child: Text(
                          holiday,
                          style: AppTextStyle.satoshi(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFBBC04),
                          ),
                        ),
                      ))
                      .toList(),
                ),
                SizedBox(height: 20.h),
                // Preview button
                AppButton(
                  text: 'Preview',
                  backgroundColor: AppColors.primary,
                  onPressed: recommendation.onPreviewTap,
                  height: 48.h,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  List<RecommendationItem> _getRecommendationsList() {
    return [
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
        dateRange: 'November 10-20',
        description: 'Take 3 days off to get 9 days of holiday',
        isHighImpact: false,
        holidays: ['Salah', 'El-fatir'],
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
        dateRange: 'May 09-12',
        description: 'Take 3 days off to get 9 days of holiday',
        isHighImpact: false,
        holidays: ['El-fatir', 'Salah'],
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
        dateRange: 'May 09-12',
        description: 'Take 3 days off to get 9 days of holiday',
        isHighImpact: false,
        holidays: ['El-fatir', 'Salah'],
        onPreviewTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlannerView(),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildAllBreaksView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with back button
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _showAllBreaks = false;
                });
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.lightBlack,
                size: 24.r,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'All Upcoming Breaks',
              style: AppTextStyle.raleway(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lightBlack,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        // List of all breaks
        GlassyContainer(
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: _getBreaksList().map((breakItem) {
              // Use MediaQuery for consistent sizing across devices
              final screenWidth = MediaQuery.of(context).size.width;
              final dateContainerWidth = screenWidth * 0.15; // 15% of screen width
              final dateContainerHeight = dateContainerWidth * 1.2; // Aspect ratio of 1.2
              
              return Padding(
                padding: EdgeInsets.only(bottom: breakItem == _getBreaksList().last ? 0 : 8.h),
                child: GestureDetector(
                  onTap: breakItem.onTap,
                  child: Container(
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
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Helper method to generate the list of breaks
  List<BreakItem> _getBreaksList() {
    return [
      BreakItem(
        title: 'Summer Vacation',
        month: 'April',
        day: '24',
        days: 5,
        status: 'Approved',
        daysRemaining: 50,
        cardColor: AppColors.lightPurple,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreakDetailView(
                breakItem: BreakItem(
                  title: 'Summer Vacation',
                  month: 'April',
                  day: '24',
                  days: 5,
                  status: 'Approved',
                  daysRemaining: 50,
                  cardColor: AppColors.lightPurple,
                ),
              ),
            ),
          );
        },
      ),
      BreakItem(
        title: 'Summer Vacation',
        month: 'April',
        day: '24',
        days: 5,
        status: 'Approved',
        daysRemaining: 50,
        cardColor: AppColors.lightGreen,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreakDetailView(
                breakItem: BreakItem(
                  title: 'Summer Vacation',
                  month: 'April',
                  day: '24',
                  days: 5,
                  status: 'Approved',
                  daysRemaining: 50,
                  cardColor: AppColors.lightGreen,
                ),
              ),
            ),
          );
        },
      ),
      BreakItem(
        title: 'Summer Vacation',
        month: 'April',
        day: '24',
        days: 5,
        status: 'Approved',
        daysRemaining: 50,
        cardColor: AppColors.orange100,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreakDetailView(
                breakItem: BreakItem(
                  title: 'Summer Vacation',
                  month: 'April',
                  day: '24',
                  days: 5,
                  status: 'Approved',
                  daysRemaining: 50,
                  cardColor: AppColors.orange100,
                ),
              ),
            ),
          );
        },
      ),
      BreakItem(
        title: 'Summer Vacation',
        month: 'April',
        day: '24',
        days: 5,
        status: 'Approved',
        daysRemaining: 50,
        cardColor: AppColors.lightPurple,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreakDetailView(
                breakItem: BreakItem(
                  title: 'Summer Vacation',
                  month: 'April',
                  day: '24',
                  days: 5,
                  status: 'Approved',
                  daysRemaining: 50,
                  cardColor: AppColors.lightPurple,
                ),
              ),
            ),
          );
        },
      ),
      // Add more breaks for the "See All" view
      BreakItem(
        title: 'Winter Break',
        month: 'Dec',
        day: '21',
        days: 7,
        status: 'Pending',
        daysRemaining: 265,
        cardColor: AppColors.orange100,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreakDetailView(
                breakItem: BreakItem(
                  title: 'Winter Break',
                  month: 'Dec',
                  day: '21',
                  days: 7,
                  status: 'Pending',
                  daysRemaining: 265,
                  cardColor: AppColors.orange100,
                ),
              ),
            ),
          );
        },
      ),
      BreakItem(
        title: 'Spring Break',
        month: 'March',
        day: '10',
        days: 4,
        status: 'Pending',
        daysRemaining: 345,
        cardColor: AppColors.lightGreen,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreakDetailView(
                breakItem: BreakItem(
                  title: 'Spring Break',
                  month: 'March',
                  day: '10',
                  days: 4,
                  status: 'Pending',
                  daysRemaining: 345,
                  cardColor: AppColors.lightGreen,
                ),
              ),
            ),
          );
        },
      ),
    ];
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