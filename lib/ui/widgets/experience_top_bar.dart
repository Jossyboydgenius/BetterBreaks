import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/app_search.dart';
import 'package:better_breaks/ui/widgets/app_tab_bar.dart';

class ExperienceTopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final VoidCallback? onFilterTap;
  final List<String> tabs;
  final int selectedTabIndex;
  final Function(int) onTabSelected;

  const ExperienceTopBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.searchController,
    this.onSearchChanged,
    this.onFilterTap,
    required this.tabs,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: MediaQuery.of(context).padding.top,
        bottom: 0,
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
          // Back button and title
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                AppBackButton(
                  onPressed: onBackTap,
                  color: Colors.white,
                  size: 18.r,
                ),

                SizedBox(height: 8.h),

                // Title
                Text(
                  title,
                  style: AppTextStyle.raleway(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: AppSearch(
              controller: searchController,
              onChanged: onSearchChanged,
              onFilterTap: onFilterTap,
            ),
          ),

          // Tab bar
          Padding(
            padding: EdgeInsets.only(
                top: 8.h, bottom: 24.h, left: 24.w, right: 24.w),
            child: AppTabBar(
              tabs: tabs,
              selectedIndex: selectedTabIndex,
              onTabSelected: onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}
