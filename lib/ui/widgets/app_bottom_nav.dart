import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
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
          color: AppColors.lightPrimary,
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
              onTap: () => onItemSelected(0),
            ),
            _buildNavItem(
              context: context,
              icon: AppIconData.checkList,
              label: 'Plan',
              index: 1,
              isSelected: selectedIndex == 1,
              onTap: () => onItemSelected(1),
            ),
            _buildNavItem(
              context: context,
              icon: AppIconData.party,
              label: 'Experience',
              index: 2,
              isSelected: selectedIndex == 2,
              onTap: () => onItemSelected(2),
            ),
            _buildNavItem(
              context: context,
              icon: AppIconData.analytics,
              label: 'Analytics',
              index: 3,
              isSelected: selectedIndex == 3,
              onTap: () => onItemSelected(3),
            ),
          ],
        ),
      ),
    );
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
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          mainAxisAlignment: isSelected ? MainAxisAlignment.start : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) 
              AppIcons(
                icon: icon,
                size: 20.r,
                color: AppColors.primary,
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
                  child: Text(
                    label,
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
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