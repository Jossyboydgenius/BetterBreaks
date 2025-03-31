import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class HolidayDistributionChart extends StatefulWidget {
  final List<Map<String, dynamic>> monthData;
  
  const HolidayDistributionChart({
    super.key,
    this.monthData = const [
      {
        'month': 'Jan',
        'breaks_planned': 7,
        'weekends': 8, 
        'public_holidays': 5,
      },
      {
        'month': 'Feb',
        'breaks_planned': 4,
        'weekends': 8, 
        'public_holidays': 8,
      },
      {
        'month': 'Mar',
        'breaks_planned': 6,
        'weekends': 8,
        'public_holidays': 12,
      },
      {
        'month': 'Apr',
        'breaks_planned': 3,
        'weekends': 15,
        'public_holidays': 2,
      },
      {
        'month': 'May',
        'breaks_planned': 8,
        'weekends': 6,
        'public_holidays': 3,
      },
      {
        'month': 'Jun',
        'breaks_planned': 5,
        'weekends': 5,
        'public_holidays': 2,
      },
    ],
  });

  @override
  State<HolidayDistributionChart> createState() => _HolidayDistributionChartState();
}

class _HolidayDistributionChartState extends State<HolidayDistributionChart> {
  int? _touchedBarIndex = 0;
  final Map<String, String> _fullMonthNames = {
    'Jan': 'January',
    'Feb': 'February',
    'Mar': 'March',
    'Apr': 'April',
    'May': 'May',
    'Jun': 'June',
  };

  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcons(
                icon: AppIconData.favourite,
                size: 28.r, 
              ),
              SizedBox(width: 8.w),
              Text(
                'Holiday Distribution',
                style: AppTextStyle.raleway(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          
          // Y-axis labels and chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Y-axis labels
              SizedBox(
                width: 30.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('30', style: _getAxisLabelStyle()),
                    SizedBox(height: 42.h),
                    Text('25', style: _getAxisLabelStyle()),
                    SizedBox(height: 42.h),
                    Text('20', style: _getAxisLabelStyle()),
                    SizedBox(height: 42.h),
                    Text('15', style: _getAxisLabelStyle()),
                    SizedBox(height: 42.h),
                    Text('10', style: _getAxisLabelStyle()),
                    SizedBox(height: 42.h),
                    Text('5', style: _getAxisLabelStyle()),
                    SizedBox(height: 42.h),
                    Text('0', style: _getAxisLabelStyle()),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              
              // Chart
              Expanded(
                child: SizedBox(
                  height: 350.h,
                  child: Stack(
                    children: [
                      _buildBarChart(),
                      if (_touchedBarIndex != null && _touchedBarIndex! >= 0 && _touchedBarIndex! < widget.monthData.length)
                        Positioned(
                          top: 20.h,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _buildSelectedMonthTooltip(widget.monthData[_touchedBarIndex!]),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Legend
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem('Breaks planned', AppColors.orange100),
                SizedBox(height: 8.h),
                _buildLegendItem('Weekends', AppColors.lightPurple),
                SizedBox(height: 8.h),
                _buildLegendItem('Public holidays', AppColors.darkAmber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getAxisLabelStyle() {
    return AppTextStyle.satoshi(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.lightBlack,
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 30,
        minY: 0,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 0,
            getTooltipColor: (barGroup) => Colors.transparent,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '',
                const TextStyle(color: Colors.transparent),
              );
            },
          ),
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                _touchedBarIndex = null;
                return;
              }
              _touchedBarIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
          },
          handleBuiltInTouches: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value >= widget.monthData.length) return const SizedBox();
                
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    widget.monthData[value.toInt()]['month'],
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
          widget.monthData.length,
          (index) => _generateBarGroup(index),
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(int index) {
    final data = widget.monthData[index];
    final breaks = data['breaks_planned'].toDouble();
    final weekends = data['weekends'].toDouble();
    final publicHolidays = data['public_holidays'].toDouble();
    
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: breaks + weekends + publicHolidays,
          width: 28.w,
          borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
          rodStackItems: [
            BarChartRodStackItem(
              0, 
              breaks, 
              AppColors.orange100,
            ),
            BarChartRodStackItem(
              breaks, 
              breaks + publicHolidays, 
              AppColors.darkAmber,
            ),
            BarChartRodStackItem(
              breaks + publicHolidays, 
              breaks + publicHolidays + weekends, 
              AppColors.lightPurple,
            ),
          ],
          borderSide: BorderSide.none,
          color: Colors.transparent,
        ),
      ],
      showingTooltipIndicators: index == _touchedBarIndex ? [0] : [],
    );
  }

  Widget _buildSelectedMonthTooltip(Map<String, dynamic> monthData) {
    final monthAbbr = monthData['month'];
    final fullMonthName = _fullMonthNames[monthAbbr] ?? monthAbbr;
    final breaks = monthData['breaks_planned'];
    final weekends = monthData['weekends'];
    final publicHolidays = monthData['public_holidays'];
    
    return Container(
      constraints: BoxConstraints(
        minWidth: 135.w,
        maxWidth: 200.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fullMonthName,
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          _buildTooltipRow('Planned', ': $breaks Days'),
          SizedBox(height: 6.h),
          _buildTooltipRow('Weekend', ': $weekends Days'),
          SizedBox(height: 6.h),
          _buildTooltipRow('Public', ': $publicHolidays Days'),
        ],
      ),
    );
  }
  
  Widget _buildTooltipRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTextStyle.satoshi(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black45,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.satoshi(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
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
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  double _calculateTooltipPosition(int index) {
    final int lastIndex = widget.monthData.length - 1;
    final double tooltipWidth = 135.w;
    final double chartWidth = MediaQuery.of(context).size.width - 60.w; // Account for padding and Y-axis
    final double barSpacing = chartWidth / widget.monthData.length;
    final double barPosition = barSpacing * index + (barSpacing / 2);
    
    // Default position (centered above bar)
    double position = barPosition - (tooltipWidth / 2);
    
    // Adjust for edges
    if (index >= lastIndex - 1) {
      // For last 2 bars, shift left to keep tooltip fully visible
      position = min(position, chartWidth - tooltipWidth - 10.w);
    } 
    
    // Ensure tooltip doesn't go off left edge
    position = max(10.w, position);
    
    return position;
  }
} 