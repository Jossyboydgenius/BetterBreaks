import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';

class PremiumFeaturesWidget extends StatelessWidget {
  final VoidCallback onUpgradePressed;
  final bool isActive;
  final String price;

  const PremiumFeaturesWidget({
    super.key,
    required this.onUpgradePressed,
    this.isActive = false,
    this.price = '£4.99',
  });

  @override
  Widget build(BuildContext context) {
    // Get device width to check for small screens
    final deviceWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = deviceWidth < 360; // Threshold for small screens

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.premiumGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            spreadRadius: 1,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium header with crown icon - make it flexible for small screens
            isSmallScreen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Crown icon centered
                      Center(
                        child: Container(
                          width: 42.r,
                          height: 42.r,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: AppIcons(
                              icon: AppIconData.crown,
                              size: 24.r,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Text centered
                      Center(
                        child: Column(
                          children: [
                            Text(
                              isActive ? 'Premium Active' : 'Premium Features',
                              style: AppTextStyle.raleway(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              isActive
                                  ? 'You have access to all premium features'
                                  : 'Unlock advanced breaks optimization',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.satoshi(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        width: 42.r,
                        height: 42.r,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: AppIcons(
                            icon: AppIconData.crown,
                            size: 24.r,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isActive
                                      ? 'Premium Active'
                                      : 'Premium Features',
                                  style: AppTextStyle.raleway(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                if (!isActive)
                                  Text(
                                    '£4.99',
                                    style: AppTextStyle.raleway(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              isActive
                                  ? 'You have access to all premium features'
                                  : 'Unlock advanced breaks optimization',
                              style: AppTextStyle.satoshi(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Container(
                height: 1,
                color: Colors.white.withOpacity(0.2),
              ),
            ),

            // Premium features list
            _buildPremiumFeatureItem('Advance holiday recommendation'),
            SizedBox(height: 16.h),
            _buildPremiumFeatureItem('Export Analytic data'),
            SizedBox(height: 16.h),
            _buildPremiumFeatureItem('Team calendar integration'),

            // Subscription status row
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppButton(
                    text:
                        isActive ? 'Cancel subscription' : 'Upgrade to premium',
                    backgroundColor: Colors.white,
                    textColor: isActive ? Colors.red : AppColors.primary,
                    fontWeight: FontWeight.w600,
                    onPressed: onUpgradePressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumFeatureItem(String feature) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIcons(
          icon: AppIconData.checkmarkBadge,
          size: 20.r,
          color: Colors.white,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            feature,
            style: AppTextStyle.satoshi(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
