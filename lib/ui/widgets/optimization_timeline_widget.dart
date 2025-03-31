import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:fl_chart/fl_chart.dart';

class OptimizationTimelineWidget extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;
  
  const OptimizationTimelineWidget({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lightBlack,
              ),
            ),
            TextButton(
              onPressed: onSeeAllTap,
              child: Text(
                'See all',
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        GlassyContainer(
          padding: EdgeInsets.all(16.r),
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppIcons(
                    icon: AppIconData.zap01,
                    size: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Optimization Timeline',
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
            ],
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
          horizontalInterval: 25,
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
        maxY: 30,
        lineBarsData: [
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
                final bool isApril = index == 3;
                return FlDotCirclePainter(
                  radius: isApril ? 6 : 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: AppColors.orange300,
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
                final days = touchedSpot.y.toInt();
                
                return LineTooltipItem(
                  'Opti. Days\n$monthName: $days Days',
                  TextStyle(
                    color: Colors.black,
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