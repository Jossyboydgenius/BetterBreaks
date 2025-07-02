import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_combined_input.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/utils/form_validators.dart';
import 'package:better_breaks/ui/widgets/app_toast.dart';
import 'package:better_breaks/ui/views/auth/password_success_view.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/themed_scaffold.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _passwordError;
  String? _confirmPasswordError;

  bool get _isFormValid =>
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _passwordError == null &&
      _confirmPasswordError == null;

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

  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        AppToast.showErrorToast('Passwords do not match');
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordSuccessView(),
        ),
      );
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
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
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

                // Title
                Text(
                  'Create a new password',
                  style: AppTextStyle.ralewayExtraBold48.copyWith(
                    color: AppThemeColors.getTextColor(context),
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
                  text: 'Reset Password',
                  onPressed: _handleResetPassword,
                  enabled: _isFormValid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
