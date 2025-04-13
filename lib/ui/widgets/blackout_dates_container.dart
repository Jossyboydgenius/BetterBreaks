import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:intl/intl.dart';

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
    if (widget.blackoutDates.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 16.w,
      runSpacing: 16.h,
      children: widget.blackoutDates.map((date) {
        return _buildBlackoutDateChip(date);
      }).toList(),
    );
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

  Widget _buildAddBlackoutButton() {
    return GestureDetector(
      onTap: widget.onAddBlackoutPeriod,
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
}
