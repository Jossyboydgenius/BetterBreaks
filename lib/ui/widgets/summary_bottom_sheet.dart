import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class SummaryBottomSheet extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;
  final VoidCallback onComplete;
  final VoidCallback? onConfirm;
  final int totalBreakDays;
  final int selectedDays;
  final int remainingDays;

  const SummaryBottomSheet({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onComplete,
    this.onConfirm,
    required this.totalBreakDays,
    required this.selectedDays,
    required this.remainingDays,
  });

  @override
  State<SummaryBottomSheet> createState() => _SummaryBottomSheetState();
}

class _SummaryBottomSheetState extends State<SummaryBottomSheet> {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void dispose() {
    _dragController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4, // 40% of screen height
      minChildSize: 0.3, // Minimum 30% of screen height
      maxChildSize: 0.9, // Maximum 90% of screen height
      snap: true,
      snapSizes: const [0.3, 0.4, 0.9],
      controller: _dragController,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppThemeColors.getCardBackgroundColor(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Draggable indicator
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 120.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppThemeColors.getDragHandleColor(context),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.r, 0, 24.r, 24.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date inputs in GlassyContainer
                        _buildDateSelectionContainer(),

                        SizedBox(height: 24.h),

                        // Leave Remaining
                        _buildLeaveRemainingContainer(),

                        // Next button
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onComplete,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
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

  Widget _buildDateSelectionContainer() {
    return GlassyContainer(
      padding: EdgeInsets.all(24.r),
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      blurSigmaX: 10,
      blurSigmaY: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Start Date
          Text(
            'Start Date',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                  widget.startDate != null
                      ? _dateFormat.format(widget.startDate!)
                      : 'Select date',
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

          // End Date
          SizedBox(height: 16.h),
          Text(
            'End Date',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                  widget.endDate != null
                      ? _dateFormat.format(widget.endDate!)
                      : 'Select date',
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
        ],
      ),
    );
  }

  Widget _buildLeaveRemainingContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave Remaining',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
        GlassyContainer(
          padding: EdgeInsets.all(24.r),
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          blurSigmaX: 10,
          blurSigmaY: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLeaveColumn('Total Break', widget.totalBreakDays),
              Text(
                '-',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                ),
              ),
              _buildLeaveColumn('Selected Days', widget.selectedDays),
              Text(
                '=',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                ),
              ),
              _buildLeaveColumn('Remaining Balance', widget.remainingDays),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveColumn(String label, int days) {
    return Column(
      children: [
        SizedBox(
          width: 85.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.lightBlack,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '$days days',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.orange100,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
