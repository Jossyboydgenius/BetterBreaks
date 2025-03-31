import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_top_bar.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/mood_check_in.dart';
import 'package:better_breaks/ui/widgets/break_recommendation_widget.dart';
import 'package:better_breaks/ui/widgets/optimization_timeline_chart.dart';
import 'dart:ui';
import 'package:better_breaks/ui/widgets/upcoming_breaks_widget.dart';
import 'package:better_breaks/data/repositories/break_repository.dart';
import 'package:better_breaks/ui/views/dashboard/widgets/dashboard_top_bar.dart';
import 'package:better_breaks/ui/views/dashboard/widgets/completed_setup_section.dart';
import 'package:better_breaks/ui/views/dashboard/widgets/leave_preference_section.dart';
import 'package:better_breaks/ui/views/dashboard/widgets/all_breaks_view.dart';
import 'package:better_breaks/ui/views/dashboard/widgets/all_recommendations_view.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';

class DashboardView extends StatefulWidget {
  final bool setupCompleted;
  
  const DashboardView({
    super.key, 
    this.setupCompleted = false
  });

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedNavIndex = 0; // 0: Dashboard, 1: Plan, 2: Experience, 3: Analytics
  double _moodValue = 2; // Initial mood (expressionless)
  late bool _setupCompleted; // Track if setup is completed
  bool _showAllBreaks = false; // Track if showing all breaks view
  bool _showAllRecommendations = false; // Track if showing all recommendations view
  final _breakRepository = BreakRepository();

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
              if (_showAllRecommendations || _showAllBreaks)
                DashboardTopBar(
                  showAllRecommendations: _showAllRecommendations,
                  showAllBreaks: _showAllBreaks,
                  onBackPressed: () {
                    setState(() {
                      _showAllBreaks = false;
                      _showAllRecommendations = false;
                    });
                  },
                )
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
                    ? AllBreaksView(breaks: _breakRepository.getBreaks(context))
                    : _showAllRecommendations 
                      ? AllRecommendationsView(recommendations: _breakRepository.getRecommendations(context))
                      : _buildDashboardContent(),
                ),
              ),
              // Add bottom padding to accommodate the bottom nav
              SizedBox(height: 80.h),
            ],
          ),
          AppBottomNav(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              if (index == _selectedNavIndex) {
                // Already on this tab, do nothing
                return;
              }
              
              _navigateToTab(index);
            },
          ),
        ],
      ),
    );
  }

  void _navigateToTab(int index) {
    switch (index) {
      case 0:
        // Already on Dashboard
        setState(() {
          _selectedNavIndex = 0;
          _showAllBreaks = false;
          _showAllRecommendations = false;
        });
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
      case 3:
        // Navigate to Analytics
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AnalyticsView(),
          ),
        );
        break;
    }
  }

  Widget _buildDashboardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _setupCompleted 
            ? const CompletedSetupSection()
            : LeavePreferenceSection(
                onSetupComplete: () {
                  setState(() {
                    _setupCompleted = true;
                  });
                },
              ),
        SizedBox(height: 24.h),
        if (_setupCompleted) ...[
          BreakRecommendationWidget(
            title: 'Breaks Recommendation',
            onSeeAllTap: () {
              setState(() {
                _showAllRecommendations = true;
              });
            },
            recommendations: _breakRepository.getRecommendations(context),
          ),
          SizedBox(height: 24.h),
        ],
        MoodCheckIn(
          onMoodSelected: (value) {
            setState(() {
              _moodValue = value;
            });
          },
        ),
        if (_setupCompleted) ...[
          SizedBox(height: 24.h),
          OptimizationTimelineChart(
            title: 'Analytics',
            onSeeAllTap: () {
              // Navigate to analytics screen
            },
            showHeader: true,
          ),
          SizedBox(height: 24.h),
          UpcomingBreaksWidget(
            title: 'Upcoming Breaks',
            onSeeAllTap: () {
              setState(() {
                _showAllBreaks = true;
              });
            },
            breaks: _breakRepository.getBreaks(context),
          ),
        ],
      ],
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