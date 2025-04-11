import 'package:better_breaks/shared/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';
import 'package:better_breaks/ui/widgets/app_boolean_switch.dart';
import 'package:better_breaks/ui/widgets/suggestions_content.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/views/setup/setup_planner_view.dart';

class SetupView extends StatefulWidget {
  const SetupView({super.key});

  @override
  State<SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  final _leaveBalanceController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedPreference;
  bool _alignWithSchool = false;
  bool _alignWithPeak = false;
  int _currentStep = 0;
  final _preferenceKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  DateTime _selectedDate = DateTime.now();
  bool _showDropdownOptions = false;
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _leaveBalanceController.dispose();
    _dateController.dispose();
    _removeDropdown();
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

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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
        Column(
          children: [
            GestureDetector(
              key: _preferenceKey,
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
                    // Divider(height: 1, color: AppColors.grey),
                    _dropdownItem('Extended Breaks'),
                    // Divider(height: 1, color: AppColors.grey),
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
                    _alignWithPeak = false;
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
                    _alignWithSchool = false;
                  });
                },
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _navigateToPage(int index) {
    if (index == 0) {
      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardView(),
        ),
      );
    }
    if (index == 1) {
      // Navigate to Planner - use SetupPlannerView instead of PlannerView
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SetupPlannerView(),
        ),
      );
    }
    // ... existing code ...
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _removeDropdown,
      child: Scaffold(
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
                                  builder: (context) => const DashboardView(
                                      setupCompleted: false),
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
      ),
    );
  }
}
