import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/widgets/multi_select_dropdown.dart';

class OptimizationGoalsContainer extends StatefulWidget {
  final List<String> selectedPreferences;
  final Function(String) onPreferenceRemoved;
  final Function(String) onPreferenceAdded;

  const OptimizationGoalsContainer({
    super.key,
    required this.selectedPreferences,
    required this.onPreferenceRemoved,
    required this.onPreferenceAdded,
  });

  @override
  State<OptimizationGoalsContainer> createState() =>
      _OptimizationGoalsContainerState();
}

class _OptimizationGoalsContainerState
    extends State<OptimizationGoalsContainer> {
  final List<String> _availablePreferences = [
    'Long Breaks',
    'Extended Breaks',
    'avoid peak seasons',
    'Frequent breaks',
    'prioritize weekends',
  ];

  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Optimization Goals',
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

          // MultiSelectDropdown for preferences
          MultiSelectDropdown(
            hintText: 'Select preference',
            options: _availablePreferences,
            selectedOptions: widget.selectedPreferences,
            onOptionSelected: widget.onPreferenceAdded,
            onOptionRemoved: widget.onPreferenceRemoved,
          ),

          SizedBox(height: 16.h),

          // Selected preferences list
          _buildSelectedPreferences(),
        ],
      ),
    );
  }

  Widget _buildSelectedPreferences() {
    if (widget.selectedPreferences.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 16.w,
      runSpacing: 16.h,
      children: widget.selectedPreferences.map((preference) {
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
                preference,
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () => widget.onPreferenceRemoved(preference),
                child: Icon(
                  Icons.close,
                  color: AppColors.primary,
                  size: 20.r,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
