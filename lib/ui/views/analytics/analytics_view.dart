import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/app_top_bar.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  int _selectedNavIndex = 3; // Analytics tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              AppTopBar(
                heading: 'Analytics',
                headingFontSize: 16,
                subheading: 'Serah Lopez',
                subheadingFontSize: 24,
                subheadingFontWeight: FontWeight.w700,
                icon: AppIconData.settings,
                iconSize: 46,
                onIconTap: () {
                  // Open settings
                },
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 100.r,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Analytics Coming Soon',
                        style: AppTextStyle.raleway(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'This feature is under development',
                        style: AppTextStyle.satoshi(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightBlack100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
          AppBottomNav(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              if (index != _selectedNavIndex) {
                _navigateToPage(index);
              }
            },
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    if (index == 0) {
      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardView(),
        ),
      );
    }
    // Other navigation options will be added later
  }
} 