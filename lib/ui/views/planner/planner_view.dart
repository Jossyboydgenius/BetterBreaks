import 'package:better_breaks/shared/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';

class PlannerView extends StatefulWidget {
  final VoidCallback? onBack;
  final bool isSetup;

  const PlannerView({
    super.key,
    this.onBack,
    this.isSetup = true,
  });

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;
  final int _currentStep = 2; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                      _buildCalendar(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grey),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          _buildCalendarHeader(),
          SizedBox(height: 16.h),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
          style: AppTextStyle.satoshi(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lightBlack,
          ),
        ),
        Row(
          children: [
            AppIcons(
              icon: AppIconData.leftArrow,
              onPressed: _previousMonth,
              size: 18.r,
              color: AppColors.lightBlack,
            ),
            SizedBox(width: 10.w),
            AppIcons(
              icon: AppIconData.rightArrow,
              onPressed: _nextMonth,
              size: 18.r,
              color: AppColors.lightBlack,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        _buildWeekdayHeader(),
        SizedBox(height: 16.h),
        _buildDaysGrid(),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    final weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays.map((day) {
        final isWeekend = day == 'S';
        return SizedBox(
          width: 32.w,
          child: Text(
            day,
            style: AppTextStyle.raleway(
              fontSize: 14.sp,
              color: isWeekend ? AppColors.orange300 : AppColors.lightBlack,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDaysGrid() {
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final dayOffset = index - (firstWeekday - 1);
        final day = dayOffset + 1;
        
        if (dayOffset < 0 || day > daysInMonth) {
          return const SizedBox();
        }

        final date = DateTime(_currentMonth.year, _currentMonth.month, day);
        final isStartDate = _startDate?.isAtSameMomentAs(date) ?? false;
        final isEndDate = _endDate?.isAtSameMomentAs(date) ?? false;
        final isInRange = _isDateInRange(date);
        final isWeekend = date.weekday == 6 || date.weekday == 7;
        final isPastDate = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

        return GestureDetector(
          onTap: isPastDate ? null : () => _onDateSelected(date),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isStartDate || isEndDate 
                  ? AppColors.orange100
                  : isInRange 
                      ? AppColors.orange200
                      : Colors.transparent,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  color: isPastDate
                      ? AppColors.grey
                      : (isStartDate || isEndDate)
                          ? Colors.white
                          : isWeekend
                              ? AppColors.orange300
                              : AppColors.lightBlack,
                  fontWeight: (isStartDate || isEndDate) ? FontWeight.w400 : FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isDateInRange(DateTime date) {
    if (_startDate == null || _endDate == null) return false;
    return date.isAfter(_startDate!) && date.isBefore(_endDate!);
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      if (_startDate == null || _endDate != null) {
        // Start new selection
        _startDate = date;
        _endDate = null;
      } else {
        // Complete the range
        if (date.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = date;
        } else {
          _endDate = date;
        }
      }
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
} 