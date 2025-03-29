import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_top_bar.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/mood_check_in.dart';
import 'dart:ui';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavIndex = 0; // 0: Dashboard, 1: Plan, 2: Experience, 3: Analytics
  double _moodValue = 2; // Initial mood (expressionless)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              AppTopBar(
                heading: 'BetterBreaks',
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLeavePreferenceSection(),
                      SizedBox(height: 24.h),
                      MoodCheckIn(
                        onMoodSelected: (value) {
                          setState(() {
                            _moodValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Add bottom padding to accommodate the bottom nav
              SizedBox(height: 80.h),
            ],
          ),
          AppBottomNav(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedNavIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeavePreferenceSection() {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Are you making the most of your breaks?',
            style: AppTextStyle.raleway(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'How well you have planned your breaks',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          AppImages(
            imagePath: AppImageData.calendarPlan,
            width: 150.w,
            height: 150.h,
          ),
          SizedBox(height: 16.h),
          Text(
            'Set up your leave preference so you can see detailed analysis',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          AppButton(
            text: 'Set up',
            backgroundColor: AppColors.primary,
            onPressed: () {
              // Navigate to setup preferences screen
            },
            height: 44.h,
          ),
        ],
      ),
    );
  }
}

// Custom thumb shape for slider
class RoundedRectangleThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;

  const RoundedRectangleThumbShape({
    required this.enabledThumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw drop shadow
    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: enabledThumbRadius)),
      Colors.black.withOpacity(0.2),
      4,
      true,
    );

    // Draw white circle
    canvas.drawCircle(center, enabledThumbRadius, fillPaint);
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);
  }
} 