import 'package:better_breaks/shared/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';
import 'package:better_breaks/ui/widgets/app_boolean_switch.dart';
import 'package:better_breaks/ui/widgets/suggestions_content.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/widgets/app_dropdown.dart';

class SetupView extends StatefulWidget {
  const SetupView({super.key});

  @override
  State<SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  final _leaveBalanceController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedPreference;
  String? _selectedWorkPattern;
  List<String> _selectedDays = ['Mon', 'Tues', 'Wed'];
  bool _alignWithSchool = false;
  bool _alignWithPeak = false;
  int _currentStep = 0;
  DateTime _selectedDate = DateTime.now();
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

  Widget _buildLeaveBalanceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Annual Leave Balance',
          style: AppTextStyle.satoshiRegular20.copyWith(
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
          style: AppTextStyle.satoshiRegular20.copyWith(
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
        SizedBox(height: 24.h),
        Text(
          'Working Pattern',
          style: AppTextStyle.satoshiRegular20.copyWith(
            fontSize: 16.sp,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
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
    );
  }

  Widget _buildPreferenceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred break type',
          style: AppTextStyle.satoshiRegular20.copyWith(
            fontSize: 16.sp,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
        AppDropdown(
          hintText: 'Select preference',
          selectedValue: _selectedPreference,
          options: const [
            'Long Weekends',
            'Extended Breaks',
            'Mix of both',
          ],
          onOptionSelected: (value) {
            setState(() {
              _selectedPreference = value;
            });
          },
        ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: AppColors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.r),
                  child: LinearProgressIndicator(
                    value: _currentStep == 0
                        ? 0.33
                        : _currentStep == 1
                            ? 0.66
                            : 1.0,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryLight),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      AppBackButton(
                        onPressed: () {
                          if (_currentStep == 0) {
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              _currentStep--;
                            });
                          }
                        },
                      ),
                      if (_currentStep == 2) ...[
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DashboardView(setupCompleted: false),
                              ),
                            );
                          },
                          child: Text(
                            'Skip',
                            style: AppTextStyle.satoshi(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentStep == 0
                              ? 'Set up your Leave balance'
                              : _currentStep == 1
                                  ? 'Customise your preference'
                                  : 'Better Breaks, Better You',
                          style: AppTextStyle.ralewayExtraBold48.copyWith(
                            fontSize: 24.sp,
                            color: AppColors.lightBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          _currentStep == 0
                              ? "Let's start by understanding your leave situation."
                              : _currentStep == 1
                                  ? 'Help us suggest the best leave days for you'
                                  : 'Here are our optimised sugestion',
                          style: AppTextStyle.satoshiRegular20.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_currentStep == 0)
                        _buildLeaveBalanceContent()
                      else if (_currentStep == 1)
                        _buildPreferenceContent()
                      else
                        SuggestionsContent(
                          onBack: () {
                            setState(() {
                              _currentStep--;
                            });
                          },
                        ),
                      if (_currentStep != 2) ...[
                        SizedBox(height: 32.h),
                        AppButton(
                          text: 'Continue',
                          backgroundColor: AppColors.primary,
                          onPressed: () {
                            setState(() {
                              _currentStep++;
                            });
                          },
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              if (_currentStep == 0) {
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  _currentStep--;
                                });
                              }
                            },
                            child: Text(
                              'Back',
                              style: AppTextStyle.satoshiRegular20.copyWith(
                                fontSize: 16.sp,
                                color: AppColors.lightBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
