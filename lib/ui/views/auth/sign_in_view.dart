import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';
import 'package:better_breaks/ui/views/auth/forgot_password_view.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_combined_input.dart';
import 'package:better_breaks/utils/form_validators.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  bool get _isFormValid =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _emailError == null &&
      _passwordError == null;

  void _validateEmail(String value) {
    setState(() {
      _emailError = FormValidators.validateEmail(value);
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _passwordError = FormValidators.validatePassword(value);
    });
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      // Simulate password check
      if (_passwordController.text != "correctPassword") {
        AppToast.showErrorToast('The password you entered was incorrect');
        return;
      }
      // Handle successful sign in
    }
  }

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
          child: Form(
            key: _formKey,
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
                AppCombinedInput(
                  fields: [
                    AppInputField(
                      controller: _emailController,
                      hintText: 'Email Address',
                      validator: FormValidators.validateEmail,
                      onChanged: _validateEmail,
                      errorText: _emailError,
                    ),
                    AppInputField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: _obscurePassword,
                      validator: FormValidators.validatePassword,
                      onChanged: _validatePassword,
                      errorText: _passwordError,
                      suffix: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.w, top: 14.h),
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
                  ],
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
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Sign In button
                AppButton(
                  text: 'Sign In',
                  onPressed: _handleSignIn,
                  enabled: _isFormValid,
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