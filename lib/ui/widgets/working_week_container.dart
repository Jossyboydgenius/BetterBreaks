import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/widgets/app_dropdown.dart';

class WorkingWeekContainer extends StatelessWidget {
  final String? selectedWorkPattern;
  final List<String> selectedDays;
  final Function(String) onWorkPatternSelected;
  final Function(List<String>) onDaysSelected;
  final Function(Map<String, dynamic>)? onShiftPatternSelected;

  const WorkingWeekContainer({
    super.key,
    this.selectedWorkPattern,
    required this.selectedDays,
    required this.onWorkPatternSelected,
    required this.onDaysSelected,
    this.onShiftPatternSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Working Week up',
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),

          SizedBox(height: 16.h),

          // Working pattern dropdown
          AppDropdown(
            hintText: 'Select working pattern',
            selectedValue: selectedWorkPattern,
            options: const [
              'Standard pattern (Mon -fri)',
              'Custom pattern',
              'Shift pattern',
            ],
            onOptionSelected: onWorkPatternSelected,
            onDaysSelected: onDaysSelected,
            onShiftPatternSelected: onShiftPatternSelected,
            initialSelectedDays: selectedDays,
            showDaysOfWeek: true,
          ),
        ],
      ),
    );
  }
}
