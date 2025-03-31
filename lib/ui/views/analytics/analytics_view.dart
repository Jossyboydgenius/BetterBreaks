import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:better_breaks/shared/widgets/app_circular_progress.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/app_top_bar.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';
import 'package:easy_pie_chart/easy_pie_chart.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  int _selectedNavIndex = 3; // Analytics tab
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
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
                heading: 'Analytics',
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
                      _buildAnalyticsSection(),
                      SizedBox(height: 32.h),
                      _buildBreakBalanceSection(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
          AppBottomNav(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              if (index != _selectedNavIndex) {
                _navigateToPage(index);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    // Calculate container height based on screen width for consistent sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenWidth * 0.65; // Same size ratio as BreakAnalysisSlider
    
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading inside the glassy container
          _buildSectionHeading(
            title: _getTitleForCurrentPage(),
            iconPath: _getIconForCurrentPage(),
            iconColor: _getColorForCurrentPage(),
          ),
          SizedBox(height: 24.h),
          
          // Slider content
          SizedBox(
            height: containerHeight,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Optimization Score
                AppCircularProgress(
                  progress: 0.85, // 85%
                  primaryLabel: "85%",
                  secondaryLabel: "Optimization\nscore",
                  progressColor: AppColors.orange100,
                ),
                
                // Total Optimization Days
                AppCircularProgress(
                  progress: 0.6, // 60%
                  primaryLabel: "60",
                  secondaryLabel: "Total optimization\ndays",
                  progressColor: AppColors.lightGreen,
                  maxValueText: "days",
                ),
                
                // Break Score
                AppCircularProgress(
                  progress: 0.1, // 10%
                  primaryLabel: "10",
                  secondaryLabel: "Break Score",
                  progressColor: AppColors.orange100,
                  iconPath: AppIconData.zapFilled,
                  maxValueText: "/100",
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Dots indicator
          Center(
            child: AppDotsIndicator(
              dotsCount: 3,
              position: _currentPage,
              activeColor: AppColors.primary,
              inactiveColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading({
    required String title,
    required String iconPath,
    required Color iconColor,
  }) {
    return Row(
      children: [
        AppIcons(
          icon: iconPath,
          size: 24.r,
          color: iconColor,
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: AppTextStyle.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.lightBlack,
          ),
        ),
      ],
    );
  }

  String _getIconForCurrentPage() {
    switch (_currentPage) {
      case 0:
        return AppIconData.zap01;
      case 1:
        return AppIconData.calendar;
      case 2:
        return AppIconData.zapFilled;
      default:
        return AppIconData.zap01;
    }
  }

  Color _getColorForCurrentPage() {
    switch (_currentPage) {
      case 0:
        return AppColors.orange100;
      case 1:
        return AppColors.lightGreen;
      case 2:
        return AppColors.orange100;
      default:
        return AppColors.orange100;
    }
  }

  String _getTitleForCurrentPage() {
    switch (_currentPage) {
      case 0:
        return 'Optimization score';
      case 1:
        return 'Total optimization days';
      case 2:
        return 'Break Score';
      default:
        return 'Optimization score';
    }
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        // Navigate to Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardView(),
          ),
        );
        break;
      case 1:
        // Navigate to Plan
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlannerView(
              isSetup: false,
              showBottomNav: true,
            ),
          ),
        );
        break;
      case 2:
        // Navigate to Experience
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ExperienceView(),
          ),
        );
        break;
      // Already on Analytics tab
    }
  }

  Widget _buildBreakBalanceSection() {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcons(
                icon: AppIconData.zapFilled,
                size: 24.r,
                color: AppColors.orange100,
              ),
              SizedBox(width: 8.w),
              Text(
                'Break Balance',
                style: AppTextStyle.raleway(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Center(
            child: Container(
              width: 250.h,
              height: 250.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  height: 200.h,
                  child: EasyPieChart(
                    children: [
                      PieData(value: 0.4, color: AppColors.orange100), // Breaks Remaining
                      PieData(value: 0.3, color: AppColors.lightPurple), // Breaks Used
                      PieData(value: 0.3, color: AppColors.lightGreen), // Breaks Planned
                    ],
                    pieType: PieType.crust,
                    gap: 0.06,
                    size: 200.h,
                    borderWidth: 20.0,
                    borderEdge: StrokeCap.round,
                    showValue: false,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          // Legend
          Column(
            children: [
              _buildLegendItem('Breaks Remaining', AppColors.orange100),
              SizedBox(height: 8.h),
              _buildLegendItem('Breaks Used', AppColors.lightPurple),
              SizedBox(height: 8.h),
              _buildLegendItem('Breaks Planned', AppColors.lightGreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.lightBlack,
          ),
        ),
      ],
    );
  }
} 