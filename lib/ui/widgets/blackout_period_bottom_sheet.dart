import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/calendar_widget.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:intl/intl.dart';

class BlackoutPeriodBottomSheet extends StatefulWidget {
  final Function(DateTime startDate, DateTime endDate) onSave;

  const BlackoutPeriodBottomSheet({
    super.key,
    required this.onSave,
  });

  @override
  State<BlackoutPeriodBottomSheet> createState() =>
      _BlackoutPeriodBottomSheetState();
}

class _BlackoutPeriodBottomSheetState extends State<BlackoutPeriodBottomSheet> {
  DateTime? _startDate;
  DateTime? _endDate;
  static final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void dispose() {
    _dragController.dispose();
    super.dispose();
  }

  String _formatSelectedDateRange() {
    if (_startDate == null) return 'Select date';

    if (_endDate == null || _isSameDay(_startDate!, _endDate!)) {
      return _dateFormat.format(_startDate!);
    } else {
      return '${_dateFormat.format(_startDate!)} - ${_dateFormat.format(_endDate!)}';
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8, // 80% of screen height
      minChildSize: 0.4, // Minimum 40% of screen height
      maxChildSize: 0.95, // Maximum 95% of screen height
      snap: true,
      snapSizes: const [0.4, 0.8, 0.95],
      controller: _dragController,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Draggable indicator
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  // Calculate new size based on drag
                  final newSize = _dragController.size -
                      (details.delta.dy / MediaQuery.of(context).size.height);
                  // Clamp to min/max bounds
                  final clampedSize = newSize.clamp(0.4, 0.95);
                  // Update controller
                  if (_dragController.size != clampedSize &&
                      clampedSize >= 0.4 &&
                      clampedSize <= 0.95) {
                    _dragController.jumpTo(clampedSize);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    width: 120.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add a black out date',
                    style: AppTextStyle.satoshi(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.r, 16.r, 24.r, 24.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Selected date display
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32.r),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                _formatSelectedDateRange(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.lightBlack,
                                ),
                              ),
                              Spacer(),
                              AppIcons(
                                icon: AppIconData.calendar,
                                size: 20.r,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Calendar
                        CalendarWidget(
                          startDate: _startDate,
                          endDate: _endDate,
                          onDateSelected: (date) {
                            setState(() {
                              _startDate = date;
                              _endDate = date; // For single date selection
                            });
                          },
                          onRangeSelected: (start, end) {
                            setState(() {
                              _startDate = start;
                              _endDate = end ?? start;
                            });
                          },
                        ),

                        SizedBox(height: 24.h),

                        // Save button
                        AppButton(
                          text: 'Save',
                          backgroundColor: AppColors.primary,
                          onPressed: _startDate == null
                              ? null
                              : () {
                                  final end = _endDate ?? _startDate!;
                                  widget.onSave(_startDate!, end);
                                  Navigator.pop(context);
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
