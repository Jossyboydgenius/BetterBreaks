import 'package:appearance/appearance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/app/theme_handler.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/themed_scaffold.dart';

class ThemeSettingsView extends StatefulWidget {
  const ThemeSettingsView({super.key});

  @override
  State<ThemeSettingsView> createState() => _ThemeSettingsViewState();
}

class _ThemeSettingsViewState extends State<ThemeSettingsView> {
  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Theme Settings',
          style: AppTextStyle.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.isDarkMode ? Colors.white : AppColors.lightBlack,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: AnimatedBuilder(
            animation: Listenable.merge([
              ValueNotifier<Object?>(Appearance.of(context)),
            ]),
            builder: (context, _) {
              final currentThemeMode =
                  Appearance.of(context)?.mode ?? ThemeMode.system;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose theme',
                    style: AppTextStyle.raleway(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? Colors.white
                          : AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // System theme option
                  _buildThemeOption(
                    context,
                    title: 'System default',
                    subtitle: 'Follows your device settings',
                    isSelected: currentThemeMode == ThemeMode.system,
                    onTap: () => _setThemeMode(ThemeMode.system),
                    leadingIcon: Icons.brightness_auto,
                  ),

                  SizedBox(height: 8.h),

                  // Light theme option
                  _buildThemeOption(
                    context,
                    title: 'Light theme',
                    subtitle: 'Standard light appearance',
                    isSelected: currentThemeMode == ThemeMode.light,
                    onTap: () => _setThemeMode(ThemeMode.light),
                    leadingIcon: Icons.light_mode_outlined,
                  ),

                  SizedBox(height: 8.h),

                  // Dark theme option
                  _buildThemeOption(
                    context,
                    title: 'Dark theme',
                    subtitle: 'Easier on the eyes in low light',
                    isSelected: currentThemeMode == ThemeMode.dark,
                    onTap: () => _setThemeMode(ThemeMode.dark),
                    leadingIcon: Icons.dark_mode_outlined,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required IconData leadingIcon,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.lightBlack : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : isDarkMode
                    ? AppColors.grey600
                    : AppColors.grey200,
            width: 2.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: (isSelected
                        ? AppColors.primary
                        : isDarkMode
                            ? AppColors.grey600
                            : AppColors.grey100)
                    .withOpacity(isSelected ? 0.15 : 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                leadingIcon,
                color: isSelected
                    ? AppColors.primary
                    : isDarkMode
                        ? Colors.white70
                        : AppColors.grey600,
                size: 24.r,
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
                      color: isDarkMode ? Colors.white : AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? Colors.white70 : AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24.r,
              ),
          ],
        ),
      ),
    );
  }

  void _setThemeMode(ThemeMode mode) {
    // Apply theme change
    context.setThemeMode(mode);

    // Force UI rebuild
    setState(() {});
  }
}
