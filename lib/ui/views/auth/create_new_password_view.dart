import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              AppIcons(
                icon: AppIconData.back,
                size: 14.r,
                color: AppColors.lightBlack,
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: 24.h),
              
              // Title
              Text(
                'Create a new password',
                style: AppTextStyle.ralewayExtraBold48.copyWith(
                  color: AppColors.lightBlack,
                  height: 1.1,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              
              // Description
              Text(
                'Your new password must be different from previous passwords.',
                style: AppTextStyle.satoshiRegular20.copyWith(
                  color: AppColors.lightGrey,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 32.h),

              // Password fields container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.grey),
                ),
                child: Column(
                  children: [
                    // New Password field
                    SizedBox(
                      height: 56.h,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle: AppTextStyle.satoshiRegular20.copyWith(
                            color: AppColors.grey600,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.w, top: 10.h),
                              child: Text(
                                _obscurePassword ? 'Show' : 'Hide',
                                style: AppTextStyle.satoshiRegular20.copyWith(
                                  color: AppColors.lightBlack,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: AppColors.grey),
                    // Confirm Password field
                    SizedBox(
                      height: 56.h,
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: AppTextStyle.satoshiRegular20.copyWith(
                            color: AppColors.grey600,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: _toggleConfirmPasswordVisibility,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.w, top: 10.h),
                              child: Text(
                                _obscureConfirmPassword ? 'Show' : 'Hide',
                                style: AppTextStyle.satoshiRegular20.copyWith(
                                  color: AppColors.lightBlack,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Reset Password button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle password reset and navigation
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/sign-in',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Reset Password',
                    style: AppTextStyle.satoshiRegular20.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 