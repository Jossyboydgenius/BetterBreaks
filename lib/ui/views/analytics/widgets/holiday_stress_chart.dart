import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:fl_chart/fl_chart.dart';

class HolidayStressChart extends StatelessWidget {
  const HolidayStressChart({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      padding: EdgeInsets.all(16.r),
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcons(
                icon: AppIconData.sidebarTop01,
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                'Holiday Taken/Stress Level',
                style: AppTextStyle.raleway(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            height: 200.h,
            width: double.infinity,
            child: _buildChart(),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Holiday Taken', AppColors.orange100),
              SizedBox(width: 24.w),
              _buildLegendItem('Stress Level', AppColors.lightPurple),
            ],
          ),
        ],
      ),
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

  Widget _buildChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppColors.grey.withOpacity(0.3),
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: AppColors.grey600,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                );
                
                String text;
                switch (value.toInt()) {
                  case 0:
                    text = 'Jan';
                    break;
                  case 1:
                    text = 'Feb';
                    break;
                  case 2:
                    text = 'Mar';
                    break;
                  case 3:
                    text = 'Apr';
                    break;
                  case 4:
                    text = 'May';
                    break;
                  case 5:
                    text = 'Jun';
                    break;
                  case 6:
                    text = 'Jul';
                    break;
                  default:
                    return Container();
                }

                return Text(text, style: style);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: AppColors.grey600,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                );
                
                return Text(
                  value.toInt().toString(),
                  style: style,
                  textAlign: TextAlign.left,
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 20,
        lineBarsData: [
          // First line - Holiday Taken (orange100)
          LineChartBarData(
            spots: const [
              FlSpot(0, 8),
              FlSpot(1, 12),
              FlSpot(2, 9),
              FlSpot(3, 15),
              FlSpot(4, 11),
              FlSpot(5, 14),
              FlSpot(6, 13),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppColors.orange200.withOpacity(0.8),
                AppColors.orange100,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: AppColors.orange100,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.orange100.withOpacity(0.3),
                  AppColors.orange100.withOpacity(0.1),
                  AppColors.orange100.withOpacity(0.0),
                ],
              ),
            ),
          ),
          // Second line - Stress Level (lightPurple)
          LineChartBarData(
            spots: const [
              FlSpot(0, 5),
              FlSpot(1, 10),
              FlSpot(2, 8),
              FlSpot(3, 12),
              FlSpot(4, 7),
              FlSpot(5, 16),
              FlSpot(6, 10),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppColors.lightPurple.withOpacity(0.8),
                AppColors.lightPurple,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: AppColors.lightPurple,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.lightPurple.withOpacity(0.5),
                  AppColors.lightPurple.withOpacity(0.3),
                  AppColors.lightPurple.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8,
            tooltipPadding: EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipColor: (touchedSpot) => Colors.white,
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
                final monthName = monthNames[touchedSpot.x.toInt()];
                final value = touchedSpot.y.toInt();
                final isHolidayLine = touchedSpot.barIndex == 0;
                
                return LineTooltipItem(
                  isHolidayLine 
                      ? 'Holiday\n$monthName: $value Days' 
                      : 'Stress\n$monthName: $value Level',
                  TextStyle(
                    color: isHolidayLine ? AppColors.orange100 : AppColors.lightPurple,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
          touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {},
          handleBuiltInTouches: true,
        ),
      ),
    );
  }
} 