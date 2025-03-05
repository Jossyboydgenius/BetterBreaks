import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class AppToast {
  static void showErrorToast(String message) {
    _showCustomToast(
      message: message,
      backgroundColor: AppColors.bgRed,
      borderColor: AppColors.lightRed,
      iconColor: AppColors.red,
      textColor: AppColors.red,
    );
  }

  static void showSuccessToast(String message) {
    _showCustomToast(
      message: message,
      backgroundColor: AppColors.bgGreen,
      borderColor: AppColors.lightGreen,
      iconColor: AppColors.green,
      textColor: AppColors.green,
    );
  }

  static void _showCustomToast({
    required String message,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    required Color textColor,
  }) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 3),
      toastBuilder: (cancelFunc) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.close,
                      size: 16.r,
                      color: iconColor,
                    ),
                    onPressed: cancelFunc,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: AppTextStyle.satoshiRegular20.copyWith(
                          color: textColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (message.contains('password')) ...[
                        SizedBox(height: 4.h),
                        Text(
                          'Kindly input the right password.',
                          style: AppTextStyle.satoshiRegular20.copyWith(
                            color: textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 