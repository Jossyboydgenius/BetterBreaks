import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_radio_button.dart';
import 'package:better_breaks/ui/widgets/app_boolean_switch.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';
import 'package:intl/intl.dart';

class SetupBottomSheet extends StatefulWidget {
  final VoidCallback onComplete;

  const SetupBottomSheet({
    super.key,
    required this.onComplete,
  });

  @override
  State<SetupBottomSheet> createState() => _SetupBottomSheetState();
}

class _SetupBottomSheetState extends State<SetupBottomSheet> {
  final _leaveBalanceController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedPreference;
  bool _alignWithSchool = false;
  bool _alignWithPeak = false;
  int _currentStep = 0; // 0: Leave Balance, 1: Preferences, 2: Completed
  DateTime _selectedDate = DateTime.now();
  bool _showDropdownOptions = false;
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormat.format(_selectedDate);
  }

  @override
  void dispose() {
    _leaveBalanceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _showPreferenceDropdown() {
    setState(() {
      _showDropdownOptions = !_showDropdownOptions;
    });
  }

  Widget _dropdownItem(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPreference = text;
          _showDropdownOptions = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: AppRadioButton(
          text: text,
          isSelected: _selectedPreference == text,
          onTap: () {
            setState(() {
              _selectedPreference = text;
              _showDropdownOptions = false;
            });
          },
        ),
      ),
    );
  }

  void _showCalendar() {
    showDialog(
      context: context,
      builder: (context) => AppCalendar(
        selectedDate: _selectedDate,
        onDateSelected: (date) {
          setState(() {
            _selectedDate = date;
            _dateController.text = _dateFormat.format(date);
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  Widget _buildLeaveBalanceContent() {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Annual Leave Balance',
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 8.h),
          AppInput(
            controller: _leaveBalanceController,
            hintText: 'Enter your leave balance',
          ),
          SizedBox(height: 24.h),
          Text(
            'Pre-determined Dates',
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 8.h),
          AppInput(
            controller: _dateController,
            hintText: 'Select date',
            icon: AppIconData.calendar,
            iconColor: AppColors.primaryLight,
            readOnly: true,
            onTap: _showCalendar,
          ),
          SizedBox(height: 32.h),
          AppButton(
            text: 'Continue',
            backgroundColor: AppColors.primary,
            onPressed: _nextStep,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceContent() {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferred break type',
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 8.h),
          Column(
            children: [
              GestureDetector(
                onTap: _showPreferenceDropdown,
                child: AppInput(
                  hintText: 'Select preference',
                  isDropdown: true,
                  readOnly: true,
                  controller: TextEditingController(text: _selectedPreference),
                ),
              ),
              if (_showDropdownOptions) ...[
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: Column(
                    children: [
                      _dropdownItem('Long Weekends'),
                      _dropdownItem('Extended Breaks'),
                      _dropdownItem('Mix of both'),
                    ],
                  ),
                ),
              ],
              if (_selectedPreference != null) ...[
                SizedBox(height: 24.h),
                AppBooleanSwitch(
                  text: 'Align with school vacations',
                  value: _alignWithSchool,
                  onChanged: (value) {
                    setState(() {
                      _alignWithSchool = value;
                      if (value) {
                        _alignWithPeak = false;
                      }
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppBooleanSwitch(
                  text: 'Align with peak travel season',
                  value: _alignWithPeak,
                  onChanged: (value) {
                    setState(() {
                      _alignWithPeak = value;
                      if (value) {
                        _alignWithSchool = false;
                      }
                    });
                  },
                ),
              ],
            ],
          ),
          SizedBox(height: 32.h),
          AppButton(
            text: 'Finish',
            backgroundColor: AppColors.primary,
            onPressed: _nextStep,
          ),
          SizedBox(height: 16.h),
          Center(
            child: GestureDetector(
              onTap: _previousStep,
              child: Text(
                'Back',
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AppIcons(
              icon: AppIconData.success,
              size: 140.r,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Dashboard already set',
            style: AppTextStyle.raleway(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Go back to your dashboard to enjoy a seamless experience .',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              color: AppColors.grey700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          AppButton(
            text: 'Go back to Dashboard',
            backgroundColor: AppColors.primary,
            onPressed: widget.onComplete,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Draggable indicator and close button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // This space ensures the close button is right-aligned
                SizedBox(width: 24.w),
                // Draggable indicator
                Container(
                  width: 60.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(2.5.r),
                  ),
                ),
                // Close button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcons(
                    icon: AppIconData.close,
                    size: 36.r,
                  ),
                ),
              ],
            ),
          ),

          // Header section
          if (_currentStep < 2) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentStep == 0
                        ? 'Set up your Leave balance'
                        : 'Customise your preference',
                    style: AppTextStyle.raleway(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _currentStep == 0
                        ? "Let's start by understanding your leave situation."
                        : 'Help us suggest the best leave days for you',
                    style: AppTextStyle.satoshi(
                      fontSize: 16.sp,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],

          // Content section
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: _currentStep == 0
                  ? _buildLeaveBalanceContent()
                  : _currentStep == 1
                      ? _buildPreferenceContent()
                      : _buildCompletedContent(),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
