import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class ExpandedWeatherForecast extends StatelessWidget {
  final VoidCallback onCollapse;

  const ExpandedWeatherForecast({
    super.key,
    required this.onCollapse,
  });

  Widget _buildWeatherRow(String day, String weatherType, String lowTemp, String highTemp) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              day,
              style: AppTextStyle.raleway(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlack,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          AppIcons(
            icon: _getWeatherIcon(weatherType),
            size: 24.r,
          ),
          SizedBox(width: 16.w),
          Text(
            '$lowTemp°',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 4.h,
              decoration: BoxDecoration(
                gradient: AppColors.weatherIndicatorGradient,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            '$highTemp°',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack,
            ),
          ),
        ],
      ),
    );
  }

  String _getWeatherIcon(String weatherType) {
    switch (weatherType.toLowerCase()) {
      case 'sunny':
        return AppIconData.sunny;
      case 'cloudy':
        return AppIconData.cloudy;
      case 'rain':
        return AppIconData.rain;
      case 'snow':
        return AppIconData.snow;
      default:
        return AppIconData.sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '10 Days Weather Prediction',
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 16.h),
        _buildWeatherRow('Today', 'sunny', '74', '96'),
        _buildWeatherRow('Sun', 'cloudy', '74', '96'),
        _buildWeatherRow('Mon', 'rain', '74', '96'),
        _buildWeatherRow('Tues', 'snow', '74', '96'),
        _buildWeatherRow('Wed', 'sunny', '74', '96'),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onCollapse,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Collapse',
                  style: AppTextStyle.raleway(
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
    );
  }
} 