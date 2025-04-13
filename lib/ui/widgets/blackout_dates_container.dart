import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/blackout_period_bottom_sheet.dart';

class BlackoutDatesContainer extends StatefulWidget {
  final List<DateTime> blackoutDates;
  final Function(DateTime) onDateRemoved;
  final VoidCallback onAddBlackoutPeriod;

  const BlackoutDatesContainer({
    super.key,
    required this.blackoutDates,
    required this.onDateRemoved,
    required this.onAddBlackoutPeriod,
  });

  @override
  State<BlackoutDatesContainer> createState() => _BlackoutDatesContainerState();
}

class _BlackoutDatesContainerState extends State<BlackoutDatesContainer> {
  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blackout Dates title
          Text(
            'Blackout Dates',
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),

          SizedBox(height: 16.h),

          // Divider
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),

          SizedBox(height: 24.h),

          // Blackout dates grid
          _buildBlackoutDatesGrid(),

          SizedBox(height: 24.h),

          // Add Blackout Period button
          _buildAddBlackoutButton(),
        ],
      ),
    );
  }

  Widget _buildBlackoutDatesGrid() {
    final dateRanges = _getBlackoutDateRanges();

    if (dateRanges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 16.w,
      runSpacing: 16.h,
      children: dateRanges.map((range) {
        if (range is DateTime) {
          return _buildBlackoutDateChip(range);
        } else {
          return _buildBlackoutDateRangeChip(range['start'], range['end']);
        }
      }).toList(),
    );
  }

  List<dynamic> _getBlackoutDateRanges() {
    if (widget.blackoutDates.isEmpty) return [];

    // Sort the dates
    final sortedDates = List<DateTime>.from(widget.blackoutDates)
      ..sort((a, b) => a.compareTo(b));

    final List<dynamic> ranges = [];
    DateTime? rangeStart;
    DateTime? rangeEnd;

    for (int i = 0; i < sortedDates.length; i++) {
      final current = sortedDates[i];

      if (rangeStart == null) {
        rangeStart = current;
        rangeEnd = current;
      } else if (current.difference(rangeEnd!).inDays == 1) {
        // Consecutive date, extend the range
        rangeEnd = current;
      } else {
        // Non-consecutive, add the previous range and start a new one
        if (_isSameDay(rangeStart!, rangeEnd!)) {
          ranges.add(rangeStart);
        } else {
          ranges.add({'start': rangeStart, 'end': rangeEnd});
        }
        rangeStart = current;
        rangeEnd = current;
      }
    }

    // Add the last range
    if (rangeStart != null) {
      if (_isSameDay(rangeStart, rangeEnd!)) {
        ranges.add(rangeStart);
      } else {
        ranges.add({'start': rangeStart, 'end': rangeEnd});
      }
    }

    return ranges;
  }

  Widget _buildBlackoutDateChip(DateTime date) {
    // Format as DD/MM/YY to match screenshot (e.g., 01/06/25)
    final dateStr = DateFormat('dd/MM/yy').format(date);

    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dateStr,
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => widget.onDateRemoved(date),
            child: Icon(
              Icons.close,
              color: AppColors.primary,
              size: 20.r,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlackoutDateRangeChip(DateTime start, DateTime end) {
    // Format as DD/MM/YY - DD/MM/YY
    final dateStr =
        '${DateFormat('dd/MM/yy').format(start)} - ${DateFormat('dd/MM/yy').format(end)}';

    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dateStr,
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              // Remove all dates in the range
              for (DateTime date = start;
                  !date.isAfter(end);
                  date = date.add(const Duration(days: 1))) {
                widget.onDateRemoved(date);
              }
            },
            child: Icon(
              Icons.close,
              color: AppColors.primary,
              size: 20.r,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddBlackoutButton() {
    return GestureDetector(
      onTap: () => _showAddBlackoutPeriodBottomSheet(),
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.primaryLight100.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: AppColors.primary,
                size: 24.r,
              ),
              SizedBox(width: 8.w),
              Text(
                'Add Blackout period',
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddBlackoutPeriodBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlackoutPeriodBottomSheet(
        onSave: (startDate, endDate) {
          setState(() {
            // Simple approach: just add dates to the list
            if (!_isSameDay(startDate, endDate)) {
              // Date range selected, add each day in the range
              for (DateTime date =
                      DateTime(startDate.year, startDate.month, startDate.day);
                  !date.isAfter(endDate);
                  date = date.add(const Duration(days: 1))) {
                widget.blackoutDates
                    .add(DateTime(date.year, date.month, date.day));
              }
            } else {
              // Single date selected, just add it
              widget.blackoutDates.add(
                  DateTime(startDate.year, startDate.month, startDate.day));
            }
          });
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
