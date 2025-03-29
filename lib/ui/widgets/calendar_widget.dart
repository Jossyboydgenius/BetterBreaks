import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/gradient_box_border.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime) onDateSelected;
  final Function(DateTime, DateTime?) onRangeSelected;

  const CalendarWidget({
    Key? key,
    this.startDate,
    this.endDate,
    required this.onDateSelected,
    required this.onRangeSelected,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _currentMonth;
  late DateTime? _startDate;
  late DateTime? _endDate;
  bool _showMonthPicker = false;
  bool _showYearPicker = false;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  @override
  void didUpdateWidget(CalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startDate != oldWidget.startDate) {
      _startDate = widget.startDate;
    }
    if (widget.endDate != oldWidget.endDate) {
      _endDate = widget.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
        border: const GradientBoxBorder(
          gradient: AppColors.calendarBorderGradient,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          _buildCalendarHeader(),
          SizedBox(height: 16.h),
          GestureDetector(
            onHorizontalDragEnd: (details) {
              // Determine swipe direction based on velocity
              if (details.primaryVelocity != null) {
                if (details.primaryVelocity! > 0) {
                  // Swiping from left to right (go to previous month)
                  _previousMonth();
                } else {
                  // Swiping from right to left (go to next month)
                  _nextMonth();
                }
              }
            },
            child: _buildCalendarGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => _showMonthPickerDialog(),
              child: Text(
                _getMonthName(_currentMonth.month),
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => _showYearPickerDialog(),
              child: Text(
                _currentMonth.year.toString(),
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            AppIcons(
              icon: AppIconData.leftArrow,
              onPressed: _previousMonth,
              size: 18.r,
              color: AppColors.lightBlack,
            ),
            SizedBox(width: 20.w),
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
        final isStartDate = _startDate?.year == date.year && 
                           _startDate?.month == date.month && 
                           _startDate?.day == date.day;
        final isEndDate = _endDate?.year == date.year && 
                          _endDate?.month == date.month && 
                          _endDate?.day == date.day;
        final isInRange = _isDateInRange(date);
        final isWeekend = date.weekday == 6 || date.weekday == 7;
        final isPastDate = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

        return TweenAnimationBuilder(
          tween: ColorTween(
            begin: Colors.transparent,
            end: isStartDate || isEndDate 
                ? AppColors.orange100
                : isInRange 
                    ? AppColors.orange200
                    : Colors.transparent,
          ),
          duration: const Duration(milliseconds: 300),
          builder: (context, Color? color, child) {
            return GestureDetector(
              onTap: isPastDate ? null : () => _onDateSelected(date),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
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
      },
    );
  }

  bool _isDateInRange(DateTime date) {
    if (_startDate == null || _endDate == null) return false;
    return date.isAfter(_startDate!) && date.isBefore(_endDate!);
  }

  void _onDateSelected(DateTime date) {
    if (_startDate == null || _endDate != null) {
      // Start new selection
      _startDate = date;
      _endDate = null;
      widget.onDateSelected(date);
    } else {
      // Complete the range
      if (date.isBefore(_startDate!)) {
        _endDate = _startDate;
        _startDate = date;
      } else {
        _endDate = date;
      }
      widget.onRangeSelected(_startDate!, _endDate);
    }
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

  void _showMonthPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatefulBuilder(
                builder: (context, setDialogState) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _currentMonth.year.toString(),
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
                                onPressed: () {
                                  setState(() {
                                    _currentMonth = DateTime(_currentMonth.year - 1, _currentMonth.month);
                                  });
                                  setDialogState(() {}); // Update dialog state
                                },
                                size: 18.r,
                                color: AppColors.lightBlack,
                              ),
                              SizedBox(width: 20.w),
                              AppIcons(
                                icon: AppIconData.rightArrow,
                                onPressed: () {
                                  setState(() {
                                    _currentMonth = DateTime(_currentMonth.year + 1, _currentMonth.month);
                                  });
                                  setDialogState(() {}); // Update dialog state
                                },
                                size: 18.r,
                                color: AppColors.lightBlack,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          final month = index + 1;
                          final isSelected = month == _currentMonth.month;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentMonth = DateTime(_currentMonth.year, month);
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.orange200 : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  _getMonthAbbreviation(month),
                                  style: AppTextStyle.satoshi(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lightBlack,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showYearPickerDialog() {
    final currentYear = _currentMonth.year;
    final years = List.generate(12, (index) => currentYear - 4 + index);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentYear.toString(),
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
                        onPressed: () {
                          setState(() {
                            _currentMonth = DateTime(_currentMonth.year - 12, _currentMonth.month);
                          });
                          Navigator.pop(context);
                          _showYearPickerDialog();
                        },
                        size: 18.r,
                        color: AppColors.lightBlack,
                      ),
                      SizedBox(width: 20.w),
                      AppIcons(
                        icon: AppIconData.rightArrow,
                        onPressed: () {
                          setState(() {
                            _currentMonth = DateTime(_currentMonth.year + 12, _currentMonth.month);
                          });
                          Navigator.pop(context);
                          _showYearPickerDialog();
                        },
                        size: 18.r,
                        color: AppColors.lightBlack,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 1.5,
                ),
                itemCount: years.length,
                itemBuilder: (context, index) {
                  final year = years[index];
                  final isSelected = year == currentYear;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentMonth = DateTime(year, _currentMonth.month);
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.orange200 : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          year.toString(),
                          style: AppTextStyle.satoshi(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBlack,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
} 