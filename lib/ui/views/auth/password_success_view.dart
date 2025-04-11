import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/ui/widgets/confetti.dart';

class PasswordSuccessView extends StatelessWidget {
  const PasswordSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Add confetti widget
          const Confetti(
            confettiCount: 70,
            colors: [
              AppColors.primary,
              AppColors.lightGreen,
              AppColors.orange100,
            ],
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Checkmark icon
                  AppIcons(
                    icon: AppIconData.success,
                    size: 120.r,
                  ),
                  SizedBox(height: 24.h),

                  // Success message
                  Text(
                    "Password changed",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.ralewayExtraBold48.copyWith(
                      color: AppColors.lightBlack,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Click on the login button below to continue.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.satoshiRegular20.copyWith(
                        color: AppColors.grey700,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Back to login button
                  AppButton(
                    text: 'Login',
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.signIn,
                        (route) => false,
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
