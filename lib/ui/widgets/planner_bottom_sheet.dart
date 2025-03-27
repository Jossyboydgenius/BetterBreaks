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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            SizedBox(height: 12.h),
            Container(
              width: 120.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: _buildForecastContainer(),
            ),
            SizedBox(height: 24.h),
            _buildExperienceSection(),
            SizedBox(height: 24.h),
            _buildActionButtons(),
            SizedBox(height: 24.h),
          ],
        ),
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
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            'Experience',
            style: AppTextStyle.raleway(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 200.h,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentEventIndex = index;
              });
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: _buildEventCard(
                  image: AppImageData.image,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: _buildEventCard(
                  image: AppImageData.image1,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: _buildEventCard(
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
              color: AppColors.grey,
              size: Size(8.r, 8.r),
              activeSize: Size(8.r, 8.r),
              spacing: EdgeInsets.symmetric(horizontal: 4.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required String image,
    required String title,
    required String location,
    required String date,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            AppImages(
              imagePath: image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    color: Colors.white.withOpacity(0.15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyle.raleway(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            AppIcons(
                              icon: AppIconData.location01,
                              size: 16.r,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                location,
                                style: AppTextStyle.satoshi(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            AppIcons(
                              icon: AppIconData.calendar01,
                              size: 16.r,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              date,
                              style: AppTextStyle.satoshi(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              price,
                              style: AppTextStyle.raleway(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          AppButton(
            text: 'Accept',
            backgroundColor: AppColors.primary,
            onPressed: () {},
            suffix: AppImages(
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
            onPressed: () {},
            suffix: AppImages(
              imagePath: AppImageData.sadPensiveFace,
              width: 20.r,
              height: 20.r,
            ),
          ),
        ],
      ),
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