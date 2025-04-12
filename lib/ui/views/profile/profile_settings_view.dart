import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/widgets/app_boolean_switch.dart';

class ProfileSettingsView extends StatefulWidget {
  final VoidCallback? onBackPressed;

  const ProfileSettingsView({
    super.key,
    this.onBackPressed,
  });

  @override
  State<ProfileSettingsView> createState() => _ProfileSettingsViewState();
}

class _ProfileSettingsViewState extends State<ProfileSettingsView> {
  // Notification state variables
  bool _breaksReminderEnabled = true;
  bool _suggestionsEnabled = true;
  bool _deadlineAlertsEnabled = false;
  bool _weeklyDigestEnabled = true;

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
                  // Premium Features Container (now first)
                  _buildPremiumFeaturesContainer(),

                  SizedBox(height: 16.h),

                  // Break Score section
                  _buildBreakScoreSection(),

                  SizedBox(height: 16.h),

                  // User Profile section
                  _buildUserProfileSection(),

                  SizedBox(height: 16.h),

                  // Work Schedule section
                  _buildWorkScheduleSection(),

                  SizedBox(height: 16.h),

                  // Notification section
                  _buildNotificationSection(),
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
            onTap: widget.onBackPressed ?? () => Navigator.pop(context),
            child: AppIcons(
              icon: AppIconData.back,
              size: 16.r,
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

  Widget _buildBreakScoreSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GlassyContainer(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon and chevron
            Row(
              children: [
                // Work icon in circle
                Container(
                  width: 42.r,
                  height: 42.r,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AppIcons(
                      icon: AppIconData.work,
                      size: 24.r,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Break score',
                  style: AppTextStyle.raleway(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlack,
                  ),
                ),
                Spacer(),
                AppIcons(
                  icon: AppIconData.rightArrow,
                  size: 14.r,
                  color: AppColors.grey800,
                ),
              ],
            ),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1,
                color: Colors.white.withOpacity(0.3),
              ),
            ),

            // Score display - using the style from break analysis
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppIcons(
                  icon: AppIconData.zapFilled,
                  size: 24.r,
                  color: AppColors.orange100,
                ),
                SizedBox(width: 8.w),
                Text(
                  '10',
                  style: AppTextStyle.raleway(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlack,
                  ),
                ),
                Text(
                  '/100',
                  style: AppTextStyle.raleway(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Motivational text
            Text(
              'You are acing this!',
              style: AppTextStyle.raleway(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lightBlack,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'You have levelled up. Unlock more badges to keep that score soaring',
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GlassyContainer(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User profile header
            Row(
              children: [
                // User initials circle
                Container(
                  width: 70.r,
                  height: 70.r,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'SL',
                      style: AppTextStyle.satoshi(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Name and email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sarah Lopez',
                        style: AppTextStyle.raleway(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Serahanderson@gmail.com',
                        style: AppTextStyle.satoshi(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit button with pen icon
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: AppIcons(
                    icon: AppIconData.pencilEdit,
                    size: 14.r,
                    color: AppColors.grey800,
                  ),
                ),
              ],
            ),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1,
                color: Colors.white.withOpacity(0.3),
              ),
            ),

            // Contact information with correct icon colors
            _buildContactInfoItem(
              AppIconData.mail,
              'Serahanderson@gmail.com',
              AppColors.orange100,
            ),

            SizedBox(height: 16.h),

            _buildContactInfoItem(
              AppIconData.location01,
              'London, UK(GMT+1)',
              AppColors.darkGreen,
            ),

            SizedBox(height: 16.h),

            _buildContactInfoItem(
              AppIconData.calendar,
              '25 BetterBreaks day (2024)',
              AppColors.blue100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoItem(String icon, String text, Color iconColor) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AppIcons(
              icon: icon,
              size: 16.r,
              color: iconColor,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: AppTextStyle.satoshi(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lightBlack,
          ),
        ),
      ],
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
              fontWeight: FontWeight.w600,
              onPressed: () {
                // Handle upgrade
              },
            ),
          ],
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

  Widget _buildWorkScheduleSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GlassyContainer(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon and pencil edit
            Row(
              children: [
                // Work schedule icon in circle
                Container(
                  width: 42.r,
                  height: 42.r,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AppIcons(
                      icon: AppIconData.work,
                      size: 24.r,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Work Schedule',
                  style: AppTextStyle.raleway(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlack,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: AppIcons(
                    icon: AppIconData.pencilEdit,
                    size: 14.r,
                    color: AppColors.grey800,
                  ),
                ),
              ],
            ),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1,
                color: Colors.white.withOpacity(0.3),
              ),
            ),

            // Working Days
            Text(
              'Working Days',
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Monday - Friday',
              style: AppTextStyle.satoshi(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey800,
              ),
            ),

            SizedBox(height: 16.h),

            // Blackout Dates
            Text(
              'Blackout Dates',
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '3 days set',
              style: AppTextStyle.satoshi(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey800,
              ),
            ),

            SizedBox(height: 16.h),

            // Maximum consecutive days
            Text(
              'Maximum consecutive days',
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '3 days',
              style: AppTextStyle.satoshi(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey800,
              ),
            ),

            SizedBox(height: 16.h),

            // Optimization goals
            Text(
              'Optimisation goals',
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'long breaks, peak season',
              style: AppTextStyle.satoshi(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GlassyContainer(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon
            Row(
              children: [
                // Notification icon in circle
                Container(
                  width: 42.r,
                  height: 42.r,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AppIcons(
                      icon: AppIconData.notification,
                      size: 24.r,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Notification',
                  style: AppTextStyle.raleway(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlack,
                  ),
                ),
              ],
            ),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1,
                color: Colors.white.withOpacity(0.3),
              ),
            ),

            // Breaks Reminder
            _buildNotificationItem(
              title: 'Breaks Reminder',
              enabled: _breaksReminderEnabled,
              onChanged: (value) {
                setState(() {
                  _breaksReminderEnabled = value;
                });
              },
            ),

            SizedBox(height: 16.h),

            // Suggestions
            _buildNotificationItem(
              title: 'Suggestions',
              enabled: _suggestionsEnabled,
              onChanged: (value) {
                setState(() {
                  _suggestionsEnabled = value;
                });
              },
            ),

            SizedBox(height: 16.h),

            // Deadline Alerts
            _buildNotificationItem(
              title: 'Deadline Alerts',
              enabled: _deadlineAlertsEnabled,
              onChanged: (value) {
                setState(() {
                  _deadlineAlertsEnabled = value;
                });
              },
            ),

            SizedBox(height: 16.h),

            // Weekly digest
            _buildNotificationItem(
              title: 'Weekly digest',
              enabled: _weeklyDigestEnabled,
              onChanged: (value) {
                setState(() {
                  _weeklyDigestEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              enabled ? 'Enabled' : 'Disabled',
              style: AppTextStyle.satoshi(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey800,
              ),
            ),
          ],
        ),
        AppBooleanSwitch(
          text: '',
          value: enabled,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
