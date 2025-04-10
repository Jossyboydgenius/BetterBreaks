import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/experience_top_bar.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';

class ExperienceView extends StatefulWidget {
  const ExperienceView({super.key});

  @override
  State<ExperienceView> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends State<ExperienceView> {
  int _selectedNavIndex = 2; // Experience tab
  int _selectedTabIndex = 0; // First tab in the tab bar
  final List<String> _tabs = ['Top picks', 'All', 'Music', 'Movies', 'Health'];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              // Experience Top Bar with "Experiences for you" heading, search, and tabs
              ExperienceTopBar(
                title: 'Experiences for you',
                onBackTap: () {
                  // Navigate to Dashboard
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardView(),
                    ),
                  );
                },
                searchController: _searchController,
                onSearchChanged: (value) {
                  // Handle search
                },
                onFilterTap: () {
                  // Handle filter tap
                },
                tabs: _tabs,
                selectedTabIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),

              // Content area (light blue background with rounded corners)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Experience content coming soon',
                      style: AppTextStyle.satoshi(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightBlack,
                      ),
                    ),
                  ),
                ),
              ),

              // Add space for the bottom nav
              SizedBox(height: 80.h),
            ],
          ),

          // Bottom navigation
          AppBottomNav(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              if (index != _selectedNavIndex) {
                _navigateToPage(index);
              }
            },
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    if (index == 0) {
      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardView(),
        ),
      );
    }
    // Other navigation options will be added later
  }
}
