import 'package:better_breaks/ui/views/auth/otp_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                'Forgot password',
                style: AppTextStyle.ralewayExtraBold48.copyWith(
                  color: AppColors.lightBlack,
                  height: 1.1,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              
              // Description
              Text(
                'Please enter your registered email so we can send a verification code.',
                style: AppTextStyle.satoshiRegular20.copyWith(
                  color: AppColors.lightGrey,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 32.h),

              // Email input field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: AppTextStyle.satoshiRegular20.copyWith(
                    color: AppColors.grey600,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 16.h,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightBlue),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Send Code button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpVerificationView(
                          email: _emailController.text,
                        ),
                      ),
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
                    'Send Code',
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