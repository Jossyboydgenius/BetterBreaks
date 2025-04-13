import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final List<String> selectedOptions;
  final Function(String) onOptionSelected;
  final Function(String) onOptionRemoved;

  const MultiSelectDropdown({
    super.key,
    required this.hintText,
    required this.options,
    required this.selectedOptions,
    required this.onOptionSelected,
    required this.onOptionRemoved,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown header
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
          },
          child: Container(
            width: double.infinity,
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: AppColors.grey),
            ),
            child: Row(
              children: [
                Text(
                  widget.hintText,
                  style: AppTextStyle.satoshi(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey600,
                  ),
                ),
                Spacer(),
                Icon(
                  _isDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.grey600,
                  size: 24.r,
                ),
              ],
            ),
          ),
        ),

        // Dropdown content
        if (_isDropdownOpen)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: widget.options.map((option) {
                bool isSelected = widget.selectedOptions.contains(option);
                return _buildOptionItem(option, isSelected);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildOptionItem(String option, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          widget.onOptionRemoved(option);
        } else {
          widget.onOptionSelected(option);
        }
        // Keep dropdown open for multiple selections
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.r,
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Text(
              option,
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
