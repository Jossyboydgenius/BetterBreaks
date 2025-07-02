import 'package:appearance/appearance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/app/theme_handler.dart';
import 'package:better_breaks/ui/views/settings/theme_settings_view.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/themed_scaffold.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Settings',
          style: AppTextStyle.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : AppColors.lightBlack,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.r),
          children: [
            _buildSectionHeader(context, 'Appearance'),
            SizedBox(height: 12.h),
            _buildSettingItem(
              context,
              icon: Icons.palette_outlined,
              title: 'Theme',
              subtitle: _getThemeModeName(context),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ThemeSettingsView()),
              ),
            ),
            SizedBox(height: 24.h),
            _buildSectionHeader(context, 'Account'),
            SizedBox(height: 12.h),
            _buildSettingItem(
              context,
              icon: Icons.person_outline,
              title: 'Profile',
              subtitle: 'Edit your personal information',
              onTap: () {
                // Navigate to profile settings
              },
            ),
            SizedBox(height: 12.h),
            _buildSettingItem(
              context,
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Manage your notifications',
              onTap: () {
                // Navigate to notification settings
              },
            ),
            SizedBox(height: 24.h),
            _buildSectionHeader(context, 'Support'),
            SizedBox(height: 12.h),
            _buildSettingItem(
              context,
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get help or contact us',
              onTap: () {
                // Navigate to help & support
              },
            ),
            SizedBox(height: 12.h),
            _buildSettingItem(
              context,
              icon: Icons.policy_outlined,
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy',
              onTap: () {
                // Navigate to privacy policy
              },
            ),
            SizedBox(height: 12.h),
            _buildSettingItem(
              context,
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              subtitle: 'Read our terms of service',
              onTap: () {
                // Navigate to terms of service
              },
            ),
            SizedBox(height: 24.h),
            _buildSettingItem(
              context,
              icon: Icons.logout,
              title: 'Log Out',
              subtitle: 'Sign out from your account',
              onTap: () {
                // Handle logout
              },
              showDivider: false,
              textColor: AppColors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDarkMode = context.isDarkMode;

    return Text(
      title.toUpperCase(),
      style: AppTextStyle.raleway(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? AppColors.primary : AppColors.grey600,
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
    bool showDivider = true,
  }) {
    final isDarkMode = context.isDarkMode;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.grey600.withOpacity(0.3)
                        : AppColors.grey100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    icon,
                    color: textColor ??
                        (isDarkMode ? Colors.white70 : AppColors.grey600),
                    size: 22.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.satoshi(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: textColor ??
                              (isDarkMode
                                  ? Colors.white
                                  : AppColors.lightBlack),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: AppTextStyle.satoshi(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: textColor != null
                              ? textColor.withOpacity(0.7)
                              : (isDarkMode
                                  ? Colors.white70
                                  : AppColors.grey500),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDarkMode ? Colors.white70 : AppColors.grey500,
                  size: 22.r,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: isDarkMode
                ? AppColors.grey600.withOpacity(0.5)
                : AppColors.grey200,
            height: 1,
          ),
      ],
    );
  }

  String _getThemeModeName(BuildContext context) {
    final themeMode = Appearance.of(context)?.mode;

    switch (themeMode) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System default';
    }
  }
}
