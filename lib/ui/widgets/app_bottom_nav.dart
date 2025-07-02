import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemSelected;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16.w,
      right: 16.w,
      bottom: 16.h,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 72.h,
        decoration: BoxDecoration(
          color: AppThemeColors.getBottomNavColor(context),
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context: context,
              icon: AppIconData.dashboard,
              label: 'Dashboard',
              index: 0,
              isSelected: selectedIndex == 0,
              onTap: () => _navigateTo(context, 0),
            ),
            _buildNavItem(
              context: context,
              icon: AppIconData.checkList,
              label: 'Plan',
              index: 1,
              isSelected: selectedIndex == 1,
              onTap: () => _navigateTo(context, 1),
            ),
            _buildNavItem(
              context: context,
              icon: AppIconData.party,
              label: 'Experience',
              index: 2,
              isSelected: selectedIndex == 2,
              onTap: () => _navigateTo(context, 2),
            ),
            _buildNavItem(
              context: context,
              icon: AppIconData.analytics,
              label: 'Analytics',
              index: 3,
              isSelected: selectedIndex == 3,
              onTap: () => _navigateTo(context, 3),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, int index) {
    // First use the callback if provided (for stateful updates)
    if (onItemSelected != null) {
      onItemSelected!(index);
      return;
    }

    // Otherwise use the navigation service
    switch (index) {
      case 0:
        if (selectedIndex != 0) {
          NavigationService.pushReplacementNamed('/dashboard');
        }
        break;
      case 1:
        if (selectedIndex != 1) {
          NavigationService.pushReplacementNamed('/planner');
        }
        break;
      case 2:
        if (selectedIndex != 2) {
          NavigationService.pushReplacementNamed('/experience');
        }
        break;
      case 3:
        if (selectedIndex != 3) {
          NavigationService.pushReplacementNamed('/analytics');
        }
        break;
    }
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String icon,
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        height: 48.h,
        constraints: BoxConstraints(
          minWidth: isSelected ? 48.w : 48.w,
          maxWidth: isSelected ? 160.w : 48.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 16.w : 0),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.selectedTabGradient : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: const Offset(0, 1),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment:
              isSelected ? MainAxisAlignment.start : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0088CC), // Darker primary
                      AppColors.primary,
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: AppIcons(
                  icon: icon,
                  size: 20.r,
                  color:
                      AppColors.primary, // This will be modified by the shader
                ),
              )
            else
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppIcons(
                    icon: icon,
                    size: 20.r,
                    color: AppColors.primary,
                  ),
                ),
              ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Flexible(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelected ? 1.0 : 0.0,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF0088CC), // Darker primary
                          AppColors.primary,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      label,
                      style: AppTextStyle.satoshi(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors
                            .primary, // This will be modified by the shader
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
