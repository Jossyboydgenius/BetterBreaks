import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:easy_pie_chart/easy_pie_chart.dart';

class BreakBalanceAnalysis extends StatelessWidget {
  const BreakBalanceAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: AppThemeColors.getCardColor(context),
      borderColor: AppThemeColors.getDividerColor(context),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcons(
                icon: AppIconData.zapFilled,
                size: 24.r,
                color: AppColors.orange100,
              ),
              SizedBox(width: 8.w),
              Text(
                'Break Balance',
                style: AppTextStyle.raleway(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppThemeColors.getTextColor(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Center(
            child: Container(
              width: 200.h,
              height: 200.h,
              decoration: BoxDecoration(
                color: AppThemeColors.getCardColor(context),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppThemeColors.getShadowColor(context),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  height: 200.h,
                  child: EasyPieChart(
                    children: [
                      PieData(
                          value: 0.6,
                          color: AppColors.orange100), // Breaks Remaining
                      PieData(
                          value: 0.2,
                          color: AppColors.lightPurple), // Breaks Used
                      PieData(
                          value: 0.2,
                          color: AppColors.lightGreen), // Breaks Planned
                    ],
                    pieType: PieType.crust,
                    gap: 0.08,
                    size: 150.h,
                    borderWidth: 20.0,
                    borderEdge: StrokeCap.round,
                    showValue: false,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          // Legend
          Column(
            children: [
              _buildLegendItem(
                  'Breaks Remaining', AppColors.orange100, context),
              SizedBox(height: 8.h),
              _buildLegendItem('Breaks Used', AppColors.lightPurple, context),
              SizedBox(height: 8.h),
              _buildLegendItem('Breaks Planned', AppColors.lightGreen, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color, BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppThemeColors.getTextColor(context),
          ),
        ),
      ],
    );
  }
}
