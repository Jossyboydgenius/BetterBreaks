import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/calendar_widget.dart';
import 'package:better_breaks/ui/widgets/planner_bottom_sheet.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';
import 'package:better_breaks/ui/widgets/planner_top_bar.dart';
import 'package:better_breaks/ui/widgets/summary_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/themed_scaffold.dart';

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
  final int _selectedNavIndex = 1; // Plan tab
  bool _showReviewScreen = false;
  final int _totalBreakDays = 12;
  final int _selectedDays = 5;
  final int _remainingDays = 7;

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  String _formatDateForDisplay(DateTime date) {
    final DateFormat monthYearFormatter = DateFormat('MMMM yyyy');
    final String monthYear = monthYearFormatter.format(date);
    return '${date.day} $monthYear';
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // TopBar
              PlannerTopBar(
                title: _showReviewScreen
                    ? 'Review your selected dates'
                    : 'Plan your breaks with BetterBreaks',
                onBackTap: () {
                  if (_showReviewScreen) {
                    setState(() {
                      _showReviewScreen = false;
                    });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardView(),
                      ),
                    );
                  }
                },
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      // Calendar
                      CalendarWidget(
                        startDate: _startDate,
                        endDate: _endDate,
                        onDateSelected: (date) {
                          setState(() {
                            _startDate = date;
                            // If we have a single date selected, use it for both start and end
                            _endDate ??= date;
                          });
                        },
                        onRangeSelected: (start, end) {
                          setState(() {
                            _startDate = start;
                            _endDate = end ?? start;
                          });
                        },
                      ),
                      // Remove the fixed height SizedBox that was causing the cut-off
                    ],
                  ),
                ),
              ),

              // Bottom padding for nav
              SizedBox(height: 80.h),
            ],
          ),

          // Bottom sheets based on current state
          if (_startDate != null && _endDate != null)
            _showReviewScreen
                ? PlannerBottomSheet(
                    startDate: _startDate,
                    endDate: _endDate,
                    description:
                        'Take ${_selectedDays.toString()} days off to get 9 days of holiday',
                    holidays: ['Christmas', 'New year'],
                    onBack: () {
                      setState(() {
                        _showReviewScreen = false;
                      });
                    },
                    onComplete: () {
                      // Handle completion, like navigating back to dashboard
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardView(),
                        ),
                      );
                    },
                  )
                : SummaryBottomSheet(
                    key: ValueKey(
                        '${_startDate?.toString()}-${_endDate?.toString()}'),
                    startDate: _startDate,
                    endDate: _endDate,
                    totalBreakDays: _totalBreakDays,
                    selectedDays: _selectedDays,
                    remainingDays: _remainingDays,
                    onComplete: () {
                      setState(() {
                        _showReviewScreen = true;
                      });
                    },
                    onStartDateChanged: (date) {
                      setState(() {
                        _startDate = date;
                      });
                    },
                    onEndDateChanged: (date) {
                      setState(() {
                        _endDate = date;
                      });
                    },
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
