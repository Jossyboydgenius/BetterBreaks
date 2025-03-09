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
import 'package:better_breaks/ui/widgets/suggestion_card.dart';

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

  Widget _buildLeaveBalanceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set up your Leave balance',
          style: AppTextStyle.ralewayExtraBold48.copyWith(
            fontSize: 24.sp,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Let's start by understanding your leave situation.",
          style: AppTextStyle.satoshiRegular20.copyWith(
            fontSize: 16.sp,
            color: AppColors.lightGrey,
          ),
        ),
        SizedBox(height: 32.h),
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

  Widget _buildPreferenceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customise your preference',
          style: AppTextStyle.ralewayExtraBold48.copyWith(
            fontSize: 24.sp,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Help us suggest the best leave days for you',
          style: AppTextStyle.satoshiRegular20.copyWith(
            fontSize: 16.sp,
            color: AppColors.lightGrey,
          ),
        ),
        SizedBox(height: 32.h),
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
                    Divider(height: 1, color: AppColors.grey),
                    _dropdownItem('Extended Breaks'),
                    Divider(height: 1, color: AppColors.grey),
                    _dropdownItem('Mix of both'),
                  ],
                ),
              ),
            ],
            if (_selectedPreference != null) ...[
              SizedBox(height: 24.h),
              AppRadioButton(
                text: 'Align with school vacations',
                isSelected: _alignWithSchool,
                onTap: () {
                  setState(() {
                    _alignWithSchool = !_alignWithSchool;
                    _alignWithPeak = false;
                  });
                },
              ),
              SizedBox(height: 16.h),
              AppRadioButton(
                text: 'Align with peak travel season',
                isSelected: _alignWithPeak,
                onTap: () {
                  setState(() {
                    _alignWithPeak = !_alignWithPeak;
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

  Widget _buildSuggestionsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Better Breaks, Better You',
          style: AppTextStyle.ralewayExtraBold48.copyWith(
            fontSize: 24.sp,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Here are our optimised sugestion',
          style: AppTextStyle.satoshiRegular20.copyWith(
            fontSize: 16.sp,
            color: AppColors.lightGrey,
          ),
        ),
        SizedBox(height: 24.h),
        SuggestionCard(
          dateRange: 'December 27-29',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: true,
          holidays: ['Christmas', 'New year'],
          onPreviewTap: () {
            // Handle preview tap
          },
        ),
        SuggestionCard(
          dateRange: 'November 10-20',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: false,
          holidays: ['Salah', 'El-fatir'],
          onPreviewTap: () {
            // Handle preview tap
          },
        ),
        SuggestionCard(
          dateRange: 'May 09-12',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: false,
          holidays: ['El-fatir', 'Salah'],
          onPreviewTap: () {
            // Handle preview tap
          },
        ),
        SuggestionCard(
          dateRange: 'May 09-12',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: false,
          holidays: ['El-fatir', 'Salah'],
          onPreviewTap: () {
            // Handle preview tap
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _removeDropdown,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              LinearProgressIndicator(
                value: _currentStep == 0 ? 0.33 : _currentStep == 1 ? 0.66 : 1.0,
                backgroundColor: AppColors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppBackButton(),
                      SizedBox(height: 24.h),
                      if (_currentStep == 0)
                        _buildLeaveBalanceStep()
                      else if (_currentStep == 1)
                        _buildPreferenceStep()
                      else
                        _buildSuggestionsStep(),
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
                    ],
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