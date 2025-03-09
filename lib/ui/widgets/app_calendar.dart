import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:intl/intl.dart';

class AppCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const AppCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  late DateTime _currentMonth;
  bool _showMonthPicker = false;
  bool _showYearPicker = false;
  bool _showCombinedPicker = false;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month);
  }

  void _togglePicker(String type) {
    setState(() {
      if (type == 'month') {
        _showMonthPicker = !_showMonthPicker;
        _showYearPicker = false;
        _showCombinedPicker = false;
      } else if (type == 'year') {
        _showYearPicker = !_showYearPicker;
        _showMonthPicker = false;
        _showCombinedPicker = false;
      } else {
        _showCombinedPicker = !_showCombinedPicker;
        _showMonthPicker = false;
        _showYearPicker = false;
      }
    });
  }

  Widget _buildMonthPicker() {
    final months = List.generate(12, (index) => DateTime(_currentMonth.year, index + 1));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            padding: EdgeInsets.all(16.r),
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            children: months.map((month) {
              final isSelected = month.month == _currentMonth.month;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, month.month);
                    _showMonthPicker = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryLight : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat('MMM').format(month),
                    style: AppTextStyle.satoshiRegular20.copyWith(
                      fontSize: 16.sp,
                      color: isSelected ? Colors.white : AppColors.lightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildYearPicker() {
    final currentYear = _currentMonth.year;
    final years = List.generate(100, (index) => currentYear - 50 + index);

    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isSelected = year == _currentMonth.year;
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentMonth = DateTime(year, _currentMonth.month);
                _showYearPicker = false;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : Colors.transparent,
              ),
              child: Text(
                year.toString(),
                style: AppTextStyle.satoshiRegular20.copyWith(
                  fontSize: 16.sp,
                  color: isSelected ? Colors.white : AppColors.lightBlack,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCombinedPicker() {
    final currentYear = _currentMonth.year;
    final years = List.generate(100, (index) => currentYear - 50 + index);
    final months = List.generate(12, (index) => DateTime(_currentMonth.year, index + 1));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.grey)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: years.map((year) {
                  final isSelected = year == _currentMonth.year;
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentMonth = DateTime(year, _currentMonth.month);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryLight : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          year.toString(),
                          style: AppTextStyle.satoshiRegular20.copyWith(
                            fontSize: 16.sp,
                            color: isSelected ? Colors.white : AppColors.lightBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            padding: EdgeInsets.all(16.r),
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            children: months.map((month) {
              final isSelected = month.month == _currentMonth.month;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, month.month);
                    _showCombinedPicker = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryLight : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat('MMM').format(month),
                    style: AppTextStyle.satoshiRegular20.copyWith(
                      fontSize: 16.sp,
                      color: isSelected ? Colors.white : AppColors.lightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                GestureDetector(
                  onTap: () => _togglePicker('combined'),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _togglePicker('month'),
                        child: Text(
                          DateFormat('MMMM').format(_currentMonth),
                          style: AppTextStyle.satoshiRegular20.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: () => _togglePicker('year'),
                        child: Text(
                          _currentMonth.year.toString(),
                          style: AppTextStyle.satoshiRegular20.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      AppIcons(
                        icon: AppIconData.updown,
                        size: 18.r,
                        color: AppColors.lightBlack,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showMonthPicker) ...[
              SizedBox(height: 8.h),
              _buildMonthPicker(),
            ] else if (_showYearPicker) ...[
              SizedBox(height: 8.h),
              _buildYearPicker(),
            ] else if (_showCombinedPicker) ...[
              SizedBox(height: 8.h),
              _buildCombinedPicker(),
            ] else ...[
              SizedBox(height: 16.h),
              // Weekday headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
                  final isWeekend = day == 'S';
                  return SizedBox(
                    width: 32.r,
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.raleway(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isWeekend ? AppColors.orange300 : AppColors.lightBlack,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 8.h),
              // Calendar grid
              ...List.generate(6, (weekIndex) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(7, (dayIndex) {
                      final date = DateTime(
                        _currentMonth.year,
                        _currentMonth.month,
                        1 + weekIndex * 7 + dayIndex - DateTime(_currentMonth.year, _currentMonth.month, 1).weekday + 1,
                      );

                      final isSelected = date.year == widget.selectedDate.year &&
                          date.month == widget.selectedDate.month &&
                          date.day == widget.selectedDate.day;

                      final isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
                      final isCurrentMonth = date.month == _currentMonth.month;

                      return GestureDetector(
                        onTap: () {
                          widget.onDateSelected(date);
                        },
                        child: Container(
                          width: 32.r,
                          height: 32.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? AppColors.orange100 : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: AppTextStyle.satoshiRegular20.copyWith(
                                fontSize: 14.sp,
                                color: !isCurrentMonth
                                    ? AppColors.grey
                                    : isSelected
                                        ? Colors.white
                                        : isWeekend
                                            ? AppColors.orange300
                                            : AppColors.lightBlack,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
} 