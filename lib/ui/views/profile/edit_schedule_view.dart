import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/blackout_dates_container.dart';
import 'package:better_breaks/ui/widgets/working_week_container.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';
import 'package:better_breaks/ui/widgets/optimization_goals_container.dart';

class EditScheduleView extends StatefulWidget {
  final String? initialWorkingPattern;
  final List<String>? initialSelectedDays;
  final List<DateTime>? initialBlackoutDates;
  final List<String>? initialOptimizationGoals;
  final Function(String?, List<String>, List<DateTime>, List<String>)? onSave;
  final Function(List<String>)? onOptimizationGoalsChanged;

  const EditScheduleView({
    super.key,
    this.initialWorkingPattern,
    this.initialSelectedDays,
    this.initialBlackoutDates,
    this.initialOptimizationGoals,
    this.onSave,
    this.onOptimizationGoalsChanged,
  });

  @override
  State<EditScheduleView> createState() => _EditScheduleViewState();
}

class _EditScheduleViewState extends State<EditScheduleView> {
  String? _selectedWorkPattern;
  List<String> _selectedDays = ['Mon', 'Tues', 'Wed'];
  List<DateTime> _blackoutDates = [];
  Map<String, dynamic>? _shiftPattern;
  List<String> _optimizationGoals = [];

  @override
  void initState() {
    super.initState();
    _selectedWorkPattern = widget.initialWorkingPattern;
    if (widget.initialSelectedDays != null) {
      _selectedDays = widget.initialSelectedDays!;
    }
    if (widget.initialBlackoutDates != null) {
      _blackoutDates = widget.initialBlackoutDates!;
    } else {
      // Demo data - add some sample blackout dates
      final now = DateTime.now();
      _blackoutDates = [
        DateTime(now.year, now.month, now.day + 5),
        DateTime(now.year, now.month, now.day + 10),
        DateTime(now.year, now.month, now.day + 15),
      ];
    }
    if (widget.initialOptimizationGoals != null) {
      _optimizationGoals = widget.initialOptimizationGoals!;
    }
  }

  void _removeBlackoutDate(DateTime date) {
    setState(() {
      _blackoutDates.removeWhere(
        (d) =>
            d.year == date.year && d.month == date.month && d.day == date.day,
      );
    });
  }

  void _showAddBlackoutPeriodDialog() {
    showDialog(
      context: context,
      builder: (context) => AppCalendar(
        selectedDate: DateTime.now(),
        onDateSelected: (date) {
          setState(() {
            // Check if date already exists
            final exists = _blackoutDates.any(
              (d) =>
                  d.year == date.year &&
                  d.month == date.month &&
                  d.day == date.day,
            );

            if (!exists) {
              _blackoutDates.add(date);
            }
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _addOptimizationGoal(String goal) {
    setState(() {
      if (!_optimizationGoals.contains(goal)) {
        _optimizationGoals.add(goal);
      }
    });
    if (widget.onOptimizationGoalsChanged != null) {
      widget.onOptimizationGoalsChanged!(_optimizationGoals);
    }
  }

  void _removeOptimizationGoal(String goal) {
    setState(() {
      _optimizationGoals.remove(goal);
    });
    if (widget.onOptimizationGoalsChanged != null) {
      widget.onOptimizationGoalsChanged!(_optimizationGoals);
    }
  }

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
                  // Working Week container
                  WorkingWeekContainer(
                    selectedWorkPattern: _selectedWorkPattern,
                    selectedDays: _selectedDays,
                    onWorkPatternSelected: (value) {
                      setState(() {
                        _selectedWorkPattern = value;
                      });
                    },
                    onDaysSelected: (days) {
                      setState(() {
                        _selectedDays = days;
                      });
                    },
                    onShiftPatternSelected: (shiftPattern) {
                      setState(() {
                        _shiftPattern = shiftPattern;
                      });
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Blackout Dates container
                  BlackoutDatesContainer(
                    blackoutDates: _blackoutDates,
                    onDateRemoved: _removeBlackoutDate,
                    onAddBlackoutPeriod: _showAddBlackoutPeriodDialog,
                  ),

                  SizedBox(height: 16.h),

                  // Optimization Goals container
                  OptimizationGoalsContainer(
                    selectedPreferences: _optimizationGoals,
                    onPreferenceRemoved: _removeOptimizationGoal,
                    onPreferenceAdded: _addOptimizationGoal,
                  ),

                  SizedBox(height: 32.h),

                  // Save button
                  AppButton(
                    text: 'Save',
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      // Save the schedule
                      if (widget.onSave != null) {
                        widget.onSave!(_selectedWorkPattern, _selectedDays,
                            _blackoutDates, _optimizationGoals);
                      }
                      Navigator.pop(context);
                    },
                  ),
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
            'Schedule',
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
}
