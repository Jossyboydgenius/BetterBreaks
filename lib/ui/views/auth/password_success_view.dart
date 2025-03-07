import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/app/routes/app_routes.dart';

class PasswordSuccessView extends StatelessWidget {
  const PasswordSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Checkmark icon
              AppIcons(
                icon: AppIconData.checkMark,
                size: 64.r,
                color: AppColors.green,
              ),
              SizedBox(height: 24.h),
              
              // Success message
              Text(
                "You've successfully changed your password",
                textAlign: TextAlign.center,
                style: AppTextStyle.satoshiRegular20.copyWith(
                  color: AppColors.lightBlack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 32.h),
              
              // Back to login button
              AppButton(
                text: 'Back to Login',
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
    );
  }
} 