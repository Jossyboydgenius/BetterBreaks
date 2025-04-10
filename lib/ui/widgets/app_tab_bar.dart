import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class AppTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const AppTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              margin: EdgeInsets.only(
                right: 10.w,
                left: index == 0
                    ? 0
                    : 0, // Add a bit of left padding for the first item
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: null, // No solid color for any tab
                gradient: isSelected
                    ? AppColors.selectedTabGradient
                    : AppColors.searchFieldGradient,
                borderRadius: BorderRadius.circular(20.r),
                border: isSelected
                    ? Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1.2,
                      )
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 2),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: const Offset(0, -1),
                        )
                      ]
                    : null,
              ),
              child: Center(
                child: isSelected
                    ? ShaderMask(
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
                          tabs[index],
                          style: AppTextStyle.satoshi(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : Text(
                        tabs[index],
                        style: AppTextStyle.satoshi(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
