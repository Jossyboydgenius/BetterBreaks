import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:intl/intl.dart';

class AppCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const AppCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CalendarHeader(
              currentDate: selectedDate,
            ),
            SizedBox(height: 16.h),
            _CalendarGrid(
              selectedDate: selectedDate,
              onDateSelected: onDateSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime currentDate;

  const _CalendarHeader({
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${DateFormat('MMMM').format(currentDate)} ${currentDate.year}',
          style: AppTextStyle.satoshiRegular20.copyWith(
            fontSize: 16.sp,
            color: AppColors.lightBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.lightBlack,
          size: 24.r,
        ),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const _CalendarGrid({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                style: AppTextStyle.satoshiRegular20.copyWith(
                  fontSize: 14.sp,
                  color: isWeekend ? AppColors.orange300 : AppColors.lightBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 8.h),
        // Calendar days
        ...List.generate(6, (weekIndex) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (dayIndex) {
                final date = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  1 + weekIndex * 7 + dayIndex - DateTime(selectedDate.year, selectedDate.month, 1).weekday + 1,
                );

                final isSelected = date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;

                final isToday = date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day;

                final isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
                final isCurrentMonth = date.month == selectedDate.month;

                return GestureDetector(
                  onTap: () => onDateSelected(date),
                  child: Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.orange100
                          : isToday
                              ? AppColors.orange200
                              : Colors.transparent,
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
                          fontWeight: isSelected || isToday ? FontWeight.w600 : FontWeight.w400,
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
    );
  }
} 