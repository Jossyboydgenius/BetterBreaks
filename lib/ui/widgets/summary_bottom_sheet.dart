import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/event_card.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';

class SummaryBottomSheet extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;
  final VoidCallback onConfirm;

  const SummaryBottomSheet({
    super.key,
    this.startDate,
    this.endDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onConfirm,
  });

  @override
  State<SummaryBottomSheet> createState() => _SummaryBottomSheetState();
}

class _SummaryBottomSheetState extends State<SummaryBottomSheet> {
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final int _totalBreak = 12;
  final int _selectedDays = 5;
  final PageController _pageController = PageController();
  int _currentEventIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showDatePicker(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDialog(
      context: context,
      builder: (context) => AppCalendar(
        selectedDate: isStartDate ? (widget.startDate ?? DateTime.now()) : (widget.endDate ?? DateTime.now()),
        onDateSelected: (date) {
          if (isStartDate) {
            widget.onStartDateChanged(date);
          } else {
            widget.onEndDateChanged(date);
          }
          Navigator.pop(context);
        },
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
        color: AppColors.background,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelectionContainer(),
                  SizedBox(height: 24.h),
                  _buildLeaveRemainingContainer(),
                  SizedBox(height: 24.h),
                  _buildExperienceSection(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
            child: AppButton(
              text: 'Confirm Selection',
              backgroundColor: AppColors.primary,
              onPressed: widget.onConfirm,
              prefix: AppImages(
                imagePath: AppImageData.starEyes,
                width: 20.r,
                height: 20.r,
              ),
            ),
          ),
        ],
      ),
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
          _buildDateInput('Start Date', widget.startDate, true),
          SizedBox(height: 16.h),
          _buildDateInput('End Date', widget.endDate, false),
        ],
      ),
    );
  }

  Widget _buildDateInput(String label, DateTime? date, bool isStartDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showDatePicker(context, isStartDate),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Row(
              children: [
                Text(
                  date != null ? _dateFormat.format(date) : 'DD/MM/YYYY',
                  style: AppTextStyle.satoshi(
                    fontSize: 16.sp,
                    color: AppColors.lightBlack,
                  ),
                ),
                const Spacer(),
                AppIcons(
                  icon: AppIconData.calendar,
                  size: 20.r,
                  color: AppColors.primaryLight,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveRemainingContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave Remaining',
          style: AppTextStyle.satoshi(
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
              _buildLeaveColumn('Total Break', _totalBreak),
              Text(
                '-',
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                ),
              ),
              _buildLeaveColumn('Selected Days', _selectedDays),
              Text(
                '=',
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                ),
              ),
              _buildLeaveColumn('Remaining Balance', _totalBreak - _selectedDays),
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
            style: AppTextStyle.satoshi(
              fontSize: 12.sp,
              color: AppColors.lightBlack,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '$days days',
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            color: AppColors.orange100,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: AppTextStyle.raleway(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: SizedBox(
            height: 240.h,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentEventIndex = index;
                });
              },
              children: [
                EventCard(
                  image: AppImageData.image,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
                EventCard(
                  image: AppImageData.image1,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
                EventCard(
                  image: AppImageData.image2,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: AppDotsIndicator(
            dotsCount: 3,
            position: _currentEventIndex,
            inactiveColor: Colors.white,
          ),
        ),
      ],
    );
  }
} 