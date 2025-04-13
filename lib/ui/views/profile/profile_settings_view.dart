import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_boolean_switch.dart';
import 'package:better_breaks/ui/views/profile/edit_profile_view.dart';

// Import the extracted widgets
import 'package:better_breaks/ui/views/profile/widgets/premium_features_widget.dart';
import 'package:better_breaks/ui/views/profile/widgets/break_score_widget.dart';
import 'package:better_breaks/ui/views/profile/widgets/section_container.dart';
import 'package:better_breaks/ui/views/profile/widgets/section_header.dart';
import 'package:better_breaks/ui/views/profile/widgets/section_divider.dart';

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
                  PremiumFeaturesWidget(
                    onUpgradePressed: () {
                      // Handle upgrade
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Break Score section
                  BreakScoreWidget(
                    onTap: () {
                      // Handle break score tap
                    },
                  ),

                  SizedBox(height: 16.h),

                  // User Profile section
                  _buildUserProfileSection(),

                  SizedBox(height: 16.h),

                  // Work Schedule section
                  _buildWorkScheduleSection(),

                  SizedBox(height: 16.h),

                  // Notification section
                  _buildNotificationSection(),

                  SizedBox(height: 16.h),

                  // Support section
                  _buildSupportSection(),

                  SizedBox(height: 16.h),

                  // Account section
                  _buildAccountSection(),

                  // Add some space at the bottom
                  SizedBox(height: 40.h),
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
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return SectionContainer(
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileView(
                        initialName: 'Sarah Lopez',
                        initialEmail: 'Serahanderson@gmail.com',
                        initialLocation: 'London, UK(GMT+1)',
                        initialBreakBalance: '25 days',
                        onSave: () {
                          // Here you could update the user data in your state management
                          // For now, we'll just use the hardcoded values
                        },
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: AppIcons(
                    icon: AppIconData.pencilEdit,
                    size: 14.r,
                    color: AppColors.grey800,
                  ),
                ),
              ),
            ],
          ),

          // Divider
          const SectionDivider(),

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

  Widget _buildWorkScheduleSection() {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with section header widget
          SectionHeader(
            title: 'Work Schedule',
            icon: AppIconData.work,
            trailing: SizedBox(
              width: 24.r,
              height: 24.r,
              child: AppIcons(
                icon: AppIconData.pencilEdit,
                size: 14.r,
                color: AppColors.grey800,
              ),
            ),
          ),

          // Divider
          const SectionDivider(),

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
    );
  }

  Widget _buildNotificationSection() {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with section header widget
          SectionHeader(
            title: 'Notification',
            icon: AppIconData.notification,
          ),

          // Divider
          const SectionDivider(),

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

  Widget _buildSupportSection() {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with section header widget
          SectionHeader(
            title: 'Support',
            icon: AppIconData.customerSupport,
          ),

          // Divider
          const SectionDivider(),

          // Send us a message option
          GestureDetector(
            onTap: () {
              // Handle sending a message
            },
            child: Text(
              'Send us a message',
              style: AppTextStyle.raleway(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with section header widget
          SectionHeader(
            title: 'Account',
            icon: AppIconData.user,
          ),

          // Divider
          const SectionDivider(),

          // Payment Method
          _buildAccountOption(
            icon: AppIconData.creditCard,
            title: 'Payment Method',
            showChevron: true,
            onTap: () {
              // Handle payment method
            },
          ),

          SizedBox(height: 16.h),

          // Privacy policy
          _buildAccountOption(
            icon: AppIconData.lockPassword,
            title: 'Privacy policy',
            showChevron: true,
            onTap: () {
              // Handle privacy policy
            },
          ),

          SizedBox(height: 16.h),

          // Log out
          _buildAccountOption(
            icon: AppIconData.logout,
            title: 'Log out',
            textColor: AppColors.red100,
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOption({
    required String icon,
    required String title,
    bool showChevron = false,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AppIcons(
            icon: icon,
            size: 24.r,
            color: textColor ?? AppColors.grey800,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.lightBlack,
              ),
            ),
          ),
          if (showChevron)
            AppIcons(
              icon: AppIconData.rightArrow,
              size: 14.r,
              color: AppColors.grey800,
            ),
        ],
      ),
    );
  }
}
