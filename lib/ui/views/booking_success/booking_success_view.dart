import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';
import 'package:better_breaks/ui/widgets/confetti.dart';

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
          Confetti(),

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Main success icon
                  Center(
                    child: AppIcons(
                      icon: AppIconData.success,
                      size: 150.r,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Success Message
                  Text(
                    'Success!',
                    style: AppTextStyle.raleway(
                      fontSize: 32.sp,
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
                      fontSize: 20.sp,
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
                      fontSize: 16.sp,
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
}
