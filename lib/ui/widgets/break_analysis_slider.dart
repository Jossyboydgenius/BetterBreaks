import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/widgets/app_circular_progress.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';

class BreakAnalysisSlider extends StatefulWidget {
  const BreakAnalysisSlider({Key? key}) : super(key: key);

  @override
  State<BreakAnalysisSlider> createState() => _BreakAnalysisSliderState();
}

class _BreakAnalysisSliderState extends State<BreakAnalysisSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate container height based on screen width for consistent sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenWidth * 0.65; // Increased from 0.6 to 0.65
    
    return Column(
      children: [
        SizedBox(
          height: containerHeight,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Optimization Score
              AppCircularProgress(
                progress: 0.85, // 85%
                primaryLabel: "85%",
                secondaryLabel: "Optimization\nscore",
                progressColor: AppColors.orange100,
              ),
              
              // Total Optimization Days
              AppCircularProgress(
                progress: 0.6, // 60%
                primaryLabel: "60",
                secondaryLabel: "Total optimization\ndays",
                progressColor: AppColors.lightGreen,
                maxValueText: "days",
              ),
              
              // Break Score
              AppCircularProgress(
                progress: 0.1, // 10%
                primaryLabel: "10",
                secondaryLabel: "Break Score",
                progressColor: AppColors.orange100,
                iconPath: AppIconData.zapFilled,
                maxValueText: "/100",
              ),
            ],
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Dots indicator
        AppDotsIndicator(
          dotsCount: 3,
          position: _currentPage,
          activeColor: AppColors.primary,
          inactiveColor: Colors.white,
        ),
      ],
    );
  }
} 