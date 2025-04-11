import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';

class BookingSuccessView extends StatelessWidget {
  final String eventTitle;

  const BookingSuccessView({
    super.key,
    required this.eventTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Confetti-like colorful circles in the background
          ..._buildConfettiBackground(),

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Success Icon in a circular container
                  Container(
                    width: 120.r,
                    height: 120.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Main success icon
                        Center(
                          child: AppIcons(
                            icon: AppIconData.success,
                            size: 60.r,
                            color: AppColors.primary,
                          ),
                        ),

                        // Party icon at the top right
                        Positioned(
                          top: 10.r,
                          right: 10.r,
                          child: Container(
                            width: 36.r,
                            height: 36.r,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.orange,
                                  AppColors.primary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: AppIcons(
                                icon: AppIconData.party,
                                size: 20.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Success Message
                  Text(
                    'Success!',
                    style: AppTextStyle.raleway(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),

                  // Booking Confirmation
                  Text(
                    'Your booking is confirmed',
                    style: AppTextStyle.raleway(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),

                  // Email Message
                  Text(
                    'We\'ve sent your booking details via email.',
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 60.h),

                  // Back to Experiences Button
                  AppButton(
                    text: 'Back to Experiences',
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      // Navigate to the experience view and clear the stack
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExperienceView(),
                        ),
                        (route) => false, // Remove all routes in the stack
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Generate confetti-like decorative elements
  List<Widget> _buildConfettiBackground() {
    // Create a list of confetti pieces with different colors, sizes and positions
    final random =
        List.generate(20, (index) => index); // Just to create 20 items

    return random.map((i) {
      // Different colors for the confetti
      final colors = [
        AppColors.primary,
        AppColors.lightGreen,
        AppColors.orange,
        AppColors.lightPurple,
      ];

      // Pick a random color
      final color = colors[i % colors.length];

      // Random position on the screen
      final top = (i * 40).toDouble().h % (1.sh - 30.h);
      final left = (i * 33).toDouble().w % (1.sw - 30.w);
      final size = (10 + (i % 10) * 2).r;

      return Positioned(
        top: top,
        left: left,
        child: Opacity(
          opacity: 0.3 + (i % 5) * 0.1, // Vary the opacity
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: i % 3 == 0 ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: i % 3 == 0 ? null : BorderRadius.circular(2.r),
            ),
          ),
        ),
      );
    }).toList();
  }
}
