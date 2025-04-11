import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/ui/widgets/calendar_widget.dart';
import 'package:better_breaks/ui/widgets/planner_bottom_sheet.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';
import 'package:better_breaks/ui/widgets/planner_top_bar.dart';

class PlannerView extends StatefulWidget {
  final bool showBottomNav;

  const PlannerView({
    super.key,
    this.showBottomNav = true,
  });

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  DateTime? _startDate;
  DateTime? _endDate;
  int _selectedNavIndex = 1; // Plan tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              // TopBar
              PlannerTopBar(
                title: 'Review your selected dates',
                onBackTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardView(),
                    ),
                  );
                },
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom padding for nav
              SizedBox(height: 80.h),
            ],
          ),

          // Bottom sheet
          PlannerBottomSheet(
            startDate: _startDate,
            endDate: _endDate,
            description: 'Take 3 days off to get 9 days of holiday',
            holidays: ['Christmas', 'New year'],
          ),

          // Bottom nav
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
