import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'dart:ui';

class ProfileSettingsView extends StatelessWidget {
  final VoidCallback? onBackPressed;

  const ProfileSettingsView({
    super.key,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar
          _buildTopBar(context),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium Features Container
                  _buildPremiumFeaturesContainer(),

                  SizedBox(height: 24.h),

                  // Settings Sections - can be expanded later
                  _buildSettingsSection('Account', [
                    SettingsItem(
                      icon: AppIconData.user,
                      title: 'Personal Information',
                      onTap: () {},
                    ),
                    SettingsItem(
                      icon: AppIconData.lockPassword,
                      title: 'Password & Security',
                      onTap: () {},
                    ),
                  ]),

                  SizedBox(height: 16.h),

                  _buildSettingsSection('Preferences', [
                    SettingsItem(
                      icon: AppIconData.calendar,
                      title: 'Calendar Settings',
                      onTap: () {},
                    ),
                    SettingsItem(
                      icon: AppIconData.notification,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                  ]),

                  SizedBox(height: 16.h),

                  _buildSettingsSection('Other', [
                    SettingsItem(
                      icon: AppIconData.sidebarTop,
                      title: 'About BetterBreaks',
                      onTap: () {},
                    ),
                    SettingsItem(
                      icon: AppIconData.logout,
                      title: 'Logout',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: onBackPressed ?? () => Navigator.pop(context),
            child: AppIcons(
              icon: AppIconData.back,
              size: 18.r,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // Title
          Text(
            'Profile & Settings',
            style: AppTextStyle.raleway(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumFeaturesContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.premiumGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 31.2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 23.3, sigmaY: 23.3),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Premium header with crown icon
                Row(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium Features',
                          style: AppTextStyle.raleway(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Unlock advanced breaks optimization',
                          style: AppTextStyle.satoshi(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

                // Upgrade button
                SizedBox(height: 24.h),
                AppButton(
                  text: 'Upgrade to premium',
                  backgroundColor: Colors.white,
                  textColor: AppColors.primary,
                  onPressed: () {
                    // Handle upgrade
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumFeatureItem(String feature) {
    return Row(
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

  Widget _buildSettingsSection(String title, List<SettingsItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          title,
          style: AppTextStyle.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),

        // Settings container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                AppIcons(
                  icon: icon,
                  size: 20.r,
                  color: AppColors.lightBlack,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.satoshi(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ),
                AppIcons(
                  icon: AppIconData.rightArrow,
                  size: 16.r,
                  color: AppColors.grey800,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              height: 1,
              color: AppColors.grey200,
            ),
          ),
      ],
    );
  }
}
