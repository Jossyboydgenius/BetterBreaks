import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/calendar_widget.dart';
import 'package:better_breaks/ui/widgets/setup_planner_bottom_sheet.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/widgets/themed_scaffold.dart';

class SetupPlannerView extends StatefulWidget {
  final VoidCallback? onBack;

  const SetupPlannerView({
    super.key,
    this.onBack,
  });

  @override
  State<SetupPlannerView> createState() => _SetupPlannerViewState();
}

class _SetupPlannerViewState extends State<SetupPlannerView> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: AppThemeColors.getDividerColor(context),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.r),
                      child: const LinearProgressIndicator(
                        value: 1.0,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryLight),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBackButton(
                        onPressed:
                            widget.onBack ?? () => Navigator.pop(context),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Better Breaks Planner',
                        style: AppTextStyle.ralewayExtraBold48.copyWith(
                          fontSize: 24.sp,
                          color: AppThemeColors.getTextColor(context),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          CalendarWidget(
                            startDate: _startDate,
                            endDate: _endDate,
                            onDateSelected: (date) {
                              setState(() {
                                _startDate = date;
                              });
                            },
                            onRangeSelected: (start, end) {
                              setState(() {
                                _startDate = start;
                                _endDate = end;
                              });
                            },
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SetupPlannerBottomSheet(
            startDate: _startDate,
            endDate: _endDate,
            description: 'Take 3 days off to get 9 days of holiday',
            holidays: ['Christmas', 'New year'],
            onComplete: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const DashboardView(setupCompleted: true),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
