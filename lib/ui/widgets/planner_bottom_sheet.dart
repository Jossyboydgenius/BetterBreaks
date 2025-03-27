import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/ui/widgets/weather_forecast_card.dart';
import 'dart:ui';

class PlannerBottomSheet extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
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
          if (startDate != null && endDate != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_formatDate(startDate!)}-${_formatDate(endDate!)}',
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
            if (description != null) ...[
              SizedBox(height: 8.h),
              Text(
                description!,
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
            if (holidays.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: holidays
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
      child: Column(
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
                  weatherType: 'sunny',
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
              onTap: onExpand,
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