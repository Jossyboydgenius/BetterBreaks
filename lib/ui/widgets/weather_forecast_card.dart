import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class WeatherForecastCard extends StatelessWidget {
  final String day;
  final String weatherType;
  final String temperature;
  final int? date;

  const WeatherForecastCard({
    super.key,
    required this.day,
    required this.weatherType,
    required this.temperature,
    this.date,
  });

  Widget _getWeatherIcon() {
    String iconPath;
    switch (weatherType.toLowerCase()) {
      case 'sunny':
        iconPath = AppIconData.sunny;
        break;
      case 'snow':
        iconPath = AppIconData.snow;
        break;
      case 'rain':
        iconPath = AppIconData.rain;
        break;
      case 'cloudy':
        iconPath = AppIconData.cloudy;
        break;
      default:
        iconPath = AppIconData.sunny;
    }
    return AppIcons(
      icon: iconPath,
      size: 24.r,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            date != null ? '$day $date' : day,
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 12.h),
          _getWeatherIcon(),
          SizedBox(height: 12.h),
          Text(
            temperature,
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              color: AppColors.lightBlack,
            ),
          ),
        ],
      ),
    );
  }
} 