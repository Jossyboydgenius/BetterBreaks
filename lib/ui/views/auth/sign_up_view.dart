import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_combined_input.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/utils/form_validators.dart';
import 'package:better_breaks/ui/widgets/app_toast.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool get _isFormValid =>
      _fullNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _nameError == null &&
      _emailError == null &&
      _passwordError == null &&
      _confirmPasswordError == null;

  void _validateName(String value) {
    setState(() {
      _nameError = FormValidators.isNameValid(value);
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _emailError = FormValidators.validateEmail(value);
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _passwordError = FormValidators.validatePassword(value);
      if (_confirmPasswordController.text.isNotEmpty) {
        _validateConfirmPassword(_confirmPasswordController.text);
      }
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      _confirmPasswordError = FormValidators.checkIfPasswordSame(
        _passwordController.text,
        value,
      );
    });
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        AppToast.showErrorToast('Passwords do not match');
        return;
      }
      // Handle successful sign up
    }
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
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                const AppBackButton(),
                SizedBox(height: 24.h),
                
                // Welcome text
                Text(
                  'Welcome',
                  style: AppTextStyle.ralewayExtraBold48.copyWith(
                    color: AppColors.lightBlack,
                    height: 1.1,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                
                // Sign in link
                Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyle.satoshiRegular20.copyWith(
                        color: AppColors.lightGrey,
                        fontSize: 16.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.pushNamed(AppRoutes.signIn);
                      },
                      child: Text(
                        "Sign in",
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

                // Replace the old container with AppCombinedInput
                AppCombinedInput(
                  fields: [
                    AppInputField(
                      controller: _fullNameController,
                      hintText: 'Full Name',
                      validator: FormValidators.isNameValid,
                      onChanged: _validateName,
                      errorText: _nameError,
                    ),
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
                    AppInputField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: _obscureConfirmPassword,
                      validator: (value) => FormValidators.checkIfPasswordSame(
                        _passwordController.text,
                        value,
                      ),
                      onChanged: _validateConfirmPassword,
                      errorText: _confirmPasswordError,
                      suffix: GestureDetector(
                        onTap: _toggleConfirmPasswordVisibility,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.w, top: 14.h),
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
                  text: 'Sign Up',
                  onPressed: _handleSignUp,
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