import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';
import 'package:better_breaks/ui/views/auth/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
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
              
              // Welcome text
              Text(
                'Welcome back',
                style: AppTextStyle.ralewayExtraBold48.copyWith(
                  color: AppColors.lightBlack,
                  height: 1.1,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              
              // Sign up link
              Row(
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyle.satoshiRegular20.copyWith(
                      color: AppColors.lightGrey,
                      fontSize: 16.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationService.pushNamed(AppRoutes.signUp);
                    },
                    child: Text(
                      "Sign up",
                      style: AppTextStyle.satoshiRegular20.copyWith(
                        color: AppColors.lightBlack,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Combined input fields container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.grey),
                ),
                child: Column(
                  children: [
                    // Email field
                    SizedBox(
                      height: 56.h, // Fixed height for input field
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
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
                        ),
                      ),
                    ),
                    // Divider
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.grey,
                    ),
                    // Password field
                    SizedBox(
                      height: 56.h, // Fixed height for input field
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
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
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordView(),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: AppTextStyle.satoshiRegular20.copyWith(
                      color: AppColors.lightBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Sign In button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: AppTextStyle.satoshiRegular20.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Or divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Or',
                      style: AppTextStyle.satoshiRegular20.copyWith(
                        color: AppColors.grey600,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.grey)),
                ],
              ),
              SizedBox(height: 24.h),

              // Social buttons
              _socialButton(
                icon: AppIconData.google,
                text: 'Continue with Google',
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              _socialButton(
                icon: AppIconData.facebook,
                text: 'Continue with Facebook',
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              _socialButton(
                icon: AppIconData.apple,
                text: 'Continue with Twitter',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: AppIcons(icon: icon, size: 24.r),
              ),
            ),
            Center(
              child: Text(
                text,
                style: AppTextStyle.satoshiRegular20.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}