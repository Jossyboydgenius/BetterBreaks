import 'package:better_breaks/ui/views/auth/otp_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/utils/form_validators.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _emailError;

  bool get _isFormValid =>
      _emailController.text.isNotEmpty && _emailError == null;

  void _validateEmail(String value) {
    setState(() {
      _emailError = FormValidators.validateEmail(value);
    });
  }

  void _handleSendCode() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationView(
            email: _emailController.text,
          ),
        ),
      );
    }
  }

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
                TextFormField(
                  controller: _emailController,
                  onChanged: _validateEmail,
                  validator: FormValidators.validateEmail,
                  style: AppTextStyle.satoshiRegular20.copyWith(
                    color: AppColors.lightBlack,
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: AppTextStyle.satoshiRegular20.copyWith(
                      color: AppColors.grey600,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                    errorText: _emailError,
                    errorStyle: AppTextStyle.satoshiRegular20.copyWith(
                      color: AppColors.red,
                      fontSize: 12.sp,
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
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.red),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.red),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Send Code button
                AppButton(
                  text: 'Send Code',
                  onPressed: _handleSendCode,
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