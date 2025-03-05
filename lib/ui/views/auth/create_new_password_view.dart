import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_combined_input.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';

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

              // Replace the old container with AppCombinedInput
              AppCombinedInput(
                fields: [
                  AppInputField(
                    controller: _passwordController,
                    hintText: 'New Password',
                    obscureText: _obscurePassword,
                    suffix: GestureDetector(
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
                  AppInputField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: _obscureConfirmPassword,
                    suffix: GestureDetector(
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
                ],
              ),
              SizedBox(height: 24.h),

              // Replace the old button with AppButton
              AppButton(
                text: 'Reset Password',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/sign-in',
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