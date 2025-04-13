import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/widgets/app_dropdown.dart';

class EditScheduleView extends StatefulWidget {
  final String? initialWorkingPattern;
  final List<String>? initialSelectedDays;
  final Function(String?, List<String>)? onSave;

  const EditScheduleView({
    super.key,
    this.initialWorkingPattern,
    this.initialSelectedDays,
    this.onSave,
  });

  @override
  State<EditScheduleView> createState() => _EditScheduleViewState();
}

class _EditScheduleViewState extends State<EditScheduleView> {
  String? _selectedWorkPattern;
  List<String> _selectedDays = ['Mon', 'Tues', 'Wed'];

  @override
  void initState() {
    super.initState();
    _selectedWorkPattern = widget.initialWorkingPattern;
    if (widget.initialSelectedDays != null) {
      _selectedDays = widget.initialSelectedDays!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar
          _buildTopBar(context),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Working Week section in glassy container
                  GlassyContainer(
                    backgroundColor: Colors.white,
                    borderColor: Colors.white,
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Working Week up',
                          style: AppTextStyle.raleway(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightBlack,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Working pattern dropdown
                        AppDropdown(
                          hintText: 'Select working pattern',
                          selectedValue: _selectedWorkPattern,
                          options: const [
                            'Standard pattern (Mon -fri)',
                            'Custom pattern',
                            'Shift pattern',
                          ],
                          onOptionSelected: (value) {
                            setState(() {
                              _selectedWorkPattern = value;
                            });
                          },
                          onDaysSelected: (days) {
                            setState(() {
                              _selectedDays = days;
                            });
                          },
                          initialSelectedDays: _selectedDays,
                          showDaysOfWeek: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Save button
                  AppButton(
                    text: 'Save',
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      // Save the schedule
                      if (widget.onSave != null) {
                        widget.onSave!(_selectedWorkPattern, _selectedDays);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppIcons(
              icon: AppIconData.back,
              size: 16.r,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // Title
          Text(
            'Schedule',
            style: AppTextStyle.raleway(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
