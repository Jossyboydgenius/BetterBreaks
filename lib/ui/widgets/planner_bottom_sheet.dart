import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/ui/widgets/weather_forecast_card.dart';
import 'dart:ui';
import 'package:better_breaks/ui/widgets/expanded_weather_forecast.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:better_breaks/ui/widgets/event_card.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/summary_bottom_sheet.dart';

class PlannerBottomSheet extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback? onExpand;
  final String? description;
  final List<String> holidays;

  const PlannerBottomSheet({
    super.key,
    this.startDate,
    this.endDate,
    this.onExpand,
    this.description,
    this.holidays = const [],
  });

  @override
  State<PlannerBottomSheet> createState() => _PlannerBottomSheetState();
}

class _PlannerBottomSheetState extends State<PlannerBottomSheet> {
  bool _isExpanded = false;
  int _currentEventIndex = 0;
  final PageController _pageController = PageController();
  bool _showSummary = false;
  DateTime? _startDate;
  DateTime? _endDate;
  int _totalBreak = 12; // Example value
  int _selectedDays = 5; // Calculate based on selected range
  final _dateFormat = DateFormat('dd/MM/yyyy');

  void _showDatePicker(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDialog(
      context: context,
      builder: (context) => AppCalendar(
        selectedDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
        onDateSelected: (date) {
          setState(() {
            if (isStartDate) {
              _startDate = date;
            } else {
              _endDate = date;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onAccept() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SummaryBottomSheet(
        startDate: _startDate,
        endDate: _endDate,
        onStartDateChanged: (date) {
          setState(() => _startDate = date);
        },
        onEndDateChanged: (date) {
          setState(() => _endDate = date);
        },
        onConfirm: () {
          // Handle confirmation
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildSummaryView() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Date',
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => _showDatePicker(context, true),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _startDate != null ? _dateFormat.format(_startDate!) : '12/09/2003',
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
                  SizedBox(height: 16.h),
                  Text(
                    'End Date',
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => _showDatePicker(context, false),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _endDate != null ? _dateFormat.format(_endDate!) : '12/09/2003',
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
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
              child: Text(
                'Leave Remaining',
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Break',
                                  style: AppTextStyle.satoshi(
                                    fontSize: 12.sp,
                                    color: AppColors.lightBlack,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '$_totalBreak days',
                                  style: AppTextStyle.satoshi(
                                    fontSize: 14.sp,
                                    color: AppColors.orange100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              '-',
                              style: AppTextStyle.satoshi(
                                fontSize: 12.sp,
                                color: AppColors.lightBlack,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Days',
                                  style: AppTextStyle.satoshi(
                                    fontSize: 12.sp,
                                    color: AppColors.lightBlack,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '$_selectedDays days',
                                  style: AppTextStyle.satoshi(
                                    fontSize: 14.sp,
                                    color: AppColors.orange100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              '=',
                              style: AppTextStyle.satoshi(
                                fontSize: 12.sp,
                                color: AppColors.lightBlack,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Remaining Balance',
                                  style: AppTextStyle.satoshi(
                                    fontSize: 12.sp,
                                    color: AppColors.lightBlack,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${_totalBreak - _selectedDays} days',
                                  style: AppTextStyle.satoshi(
                                    fontSize: 14.sp,
                                    color: AppColors.orange100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
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
          // Fixed draggable indicator
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
          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_showSummary) ...[
                    _buildForecastContainer(),
                    SizedBox(height: 24.h),
                    _buildExperienceSection(),
                    SizedBox(height: 24.h),
                    AppButton(
                      text: 'Accept',
                      backgroundColor: AppColors.primary,
                      onPressed: _onAccept,
                      prefix: AppImages(
                        imagePath: AppImageData.starEyes,
                        width: 20.r,
                        height: 20.r,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    AppButton(
                      text: 'Decline',
                      backgroundColor: Colors.white,
                      textColor: AppColors.lightBlack,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      prefix: AppImages(
                        imagePath: AppImageData.sadPensiveFace,
                        width: 20.r,
                        height: 20.r,
                      ),
                    ),
                  ] else ...[
                    AppButton(
                      text: 'Confirm Selection',
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        // Handle confirm selection
                      },
                      prefix: AppImages(
                        imagePath: AppImageData.starEyes,
                        width: 20.r,
                        height: 20.r,
                      ),
                    ),
                  ],
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateRangeSection(),
              Divider(color: Colors.white.withOpacity(0.5), height: 1.h),
              _buildWeatherSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeSection() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.startDate != null && widget.endDate != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_formatDate(widget.startDate!)}-${_formatDate(widget.endDate!)}',
                  style: AppTextStyle.raleway(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlack,
                  ),
                ),
                const AppBadge(
                  text: 'High Impact',
                  backgroundColor: AppColors.bgRed100,
                  textColor: AppColors.red100,
                ),
              ],
            ),
            if (widget.description != null) ...[
              SizedBox(height: 8.h),
              Text(
                widget.description!,
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
            if (widget.holidays.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: widget.holidays
                    .map((holiday) => AppBadge.holiday(name: holiday))
                    .toList(),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildWeatherSection() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: _isExpanded
          ? ExpandedWeatherForecast(
              onCollapse: () => setState(() => _isExpanded = false),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '10 Day weather Forecast',
                  style: AppTextStyle.satoshi(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlack,
                  ),
                ),
                SizedBox(height: 16.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WeatherForecastCard(
                        day: 'Wed',
                        date: 11,
                        weatherType: 'sunny',
                        temperature: '49°',
                      ),
                      SizedBox(width: 12.w),
                      WeatherForecastCard(
                        day: 'Sun',
                        date: 12,
                        weatherType: 'cloudy',
                        temperature: '49°',
                      ),
                      SizedBox(width: 12.w),
                      WeatherForecastCard(
                        day: 'Mon',
                        date: 13,
                        weatherType: 'sunny',
                        temperature: '49°',
                      ),
                      SizedBox(width: 12.w),
                      WeatherForecastCard(
                        day: 'Tues',
                        date: 14,
                        weatherType: 'sunny',
                        temperature: '49°',
                      ),
                      SizedBox(width: 12.w),
                      WeatherForecastCard(
                        day: 'Tues',
                        date: 15,
                        weatherType: 'sunny',
                        temperature: '49°',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => setState(() => _isExpanded = true),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Expand',
                          style: AppTextStyle.satoshi(
                            fontSize: 14.sp,
                            color: AppColors.lightBlack,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        AppIcons(
                          icon: AppIconData.expand,
                          size: 16.r,
                          color: AppColors.lightBlack,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Experience',
            style: AppTextStyle.raleway(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 240.h,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentEventIndex = index;
              });
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: EventCard(
                  image: AppImageData.image,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: EventCard(
                  image: AppImageData.image1,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: EventCard(
                  image: AppImageData.image2,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: DotsIndicator(
            dotsCount: 3,
            position: _currentEventIndex,
            decorator: DotsDecorator(
              activeColor: AppColors.primary,
              color: Colors.white,
              size: Size(8.r, 8.r),
              activeSize: Size(8.r, 8.r),
              spacing: EdgeInsets.symmetric(horizontal: 4.w),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
} 