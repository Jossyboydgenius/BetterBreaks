import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/calendar_widget.dart';
import 'package:better_breaks/ui/widgets/planner_bottom_sheet.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';

class PlannerView extends StatefulWidget {
  final VoidCallback? onBack;
  final bool isSetup;
  final bool showBottomNav;

  const PlannerView({
    super.key,
    this.onBack,
    this.isSetup = true,
    this.showBottomNav = false,
  });

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  DateTime? _startDate;
  DateTime? _endDate;
  final int _currentStep = 2;
  int _selectedNavIndex = 1; // Plan tab 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isSetup) ...[
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        color: AppColors.grey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.r),
                        child: const LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
                        ),
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBackButton(
                        onPressed: widget.onBack ?? () => Navigator.pop(context),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Better Breaks Planner',
                        style: AppTextStyle.ralewayExtraBold48.copyWith(
                          fontSize: 24.sp,
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          CalendarWidget(
                            startDate: _startDate,
                            endDate: _endDate,
                            onDateSelected: (date) {
                              setState(() {
                                _startDate = date;
                              });
                            },
                            onRangeSelected: (start, end) {
                              setState(() {
                                _startDate = start;
                                _endDate = end;
                              });
                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PlannerBottomSheet(
            startDate: _startDate,
            endDate: _endDate,
            description: 'Take 3 days off to get 9 days of holiday',
            holidays: ['Christmas', 'New year'],
            onComplete: widget.isSetup ? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardView(setupCompleted: true),
                ),
              );
            } : null,
          ),
          if (widget.showBottomNav)
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
  
  void _navigateToPage(int index) {
    if (index == 0) {
      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardView(),
        ),
      );
    } else if (index == 2) {
      // Navigate to Experience
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ExperienceView(),
        ),
      );
    } else if (index == 3) {
      // Navigate to Analytics
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AnalyticsView(),
        ),
      );
    }
  }
} 