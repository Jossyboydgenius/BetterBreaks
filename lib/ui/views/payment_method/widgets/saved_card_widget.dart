import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class SavedCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final VoidCallback onTap;

  const SavedCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.onTap,
  });

  String get _maskedCardNumber {
    // Show only last 3 digits of card number
    if (cardNumber.length > 4) {
      return '${cardNumber.substring(0, 4)} **** **** ${cardNumber.substring(cardNumber.length - 3)}';
    }
    return cardNumber;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Card icon in circle
            Container(
              width: 40.r,
              height: 40.r,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppIcons(
                  icon: AppIconData.creditCard,
                  size: 20.r,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Card details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Number',
                    style: AppTextStyle.satoshi(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _maskedCardNumber,
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ],
              ),
            ),
            // Name on card
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name on Card',
                    style: AppTextStyle.satoshi(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    cardHolderName,
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
