import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;
  final bool loading;
  final bool enabled;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isOutlined = false,
    this.loading = false,
    this.enabled = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = !enabled || loading;
    
    return SizedBox(
      width: double.infinity,
      height: height ?? 48.h,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? AppColors.grey
              : (isOutlined ? Colors.white : (backgroundColor ?? AppColors.lightBlue)),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: isOutlined ? BorderSide(color: backgroundColor ?? AppColors.grey) : BorderSide.none,
          ),
        ),
        child: loading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isOutlined ? (backgroundColor ?? AppColors.lightBlue) : Colors.white,
                  ),
                ),
              )
            : Text(
                text,
                style: AppTextStyle.satoshiRegular20.copyWith(
                  color: isOutlined
                      ? (textColor ?? backgroundColor ?? AppColors.lightBlue)
                      : (textColor ?? Colors.white),
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyle.satoshiRegular20.copyWith(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    );
  }
} 