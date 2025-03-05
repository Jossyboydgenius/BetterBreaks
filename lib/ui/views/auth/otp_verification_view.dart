import 'dart:async';
import 'package:better_breaks/ui/views/auth/create_new_password_view.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_otp_input.dart';
import 'package:better_breaks/ui/widgets/app_toast.dart';

class OtpVerificationView extends StatefulWidget {
  final String email;

  const OtpVerificationView({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  Timer? _timer;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
    for (var i = 0; i < 6; i++) {
      _focusNodes[i].addListener(() {
        setState(() {}); // Rebuild to update border colors
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        timer.cancel();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _handleKeyPress(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controllers[index].text.isEmpty && index > 0) {
          _focusNodes[index - 1].requestFocus();
          _controllers[index - 1].clear();
        }
      }
    }
  }

  // Add this getter to check if all OTP fields are filled
  bool get _isOtpComplete {
    return _controllers.every((controller) => controller.text.isNotEmpty);
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
                'OTP Verification',
                style: AppTextStyle.ralewayExtraBold48.copyWith(
                  color: AppColors.lightBlack,
                  height: 1.1,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              
              // Description
              Text(
                'Please enter the 6 digit code we sent to',
                style: AppTextStyle.satoshiRegular20.copyWith(
                  color: AppColors.lightGrey,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                widget.email,
                style: AppTextStyle.satoshiRegular20.copyWith(
                  color: AppColors.lightGrey,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 32.h),

              // OTP input fields
              AppOtpInput(
                controllers: _controllers,
                focusNodes: _focusNodes,
                onChanged: _onOtpDigitChanged,
                onKeyPress: _handleKeyPress,
              ),
              SizedBox(height: 24.h),

              // Replace the existing Verify button with AppButton
              AppButton(
                text: 'Verify',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNewPasswordView(),
                    ),
                  );
                },
                enabled: _isOtpComplete,
              ),
              SizedBox(height: 24.h),

              // Resend code
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code? ",
                      style: AppTextStyle.satoshiRegular20.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: _countdown == 0 ? () {
                        setState(() {
                          _countdown = 60; // Reset countdown
                          startTimer(); // Restart timer
                        });
                        AppToast.showSuccessToast('OTP code has been resent successfully');
                      } : null,
                      child: Text(
                        _countdown > 0
                            ? 'Tap to resend in ${_countdown}s'
                            : 'Tap to resend',
                        style: AppTextStyle.satoshiRegular20.copyWith(
                          color: AppColors.orange100,
                          fontSize: 14.sp,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          decorationColor: AppColors.orange100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 