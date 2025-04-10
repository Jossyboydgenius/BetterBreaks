import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/experience_top_bar.dart';
import 'package:better_breaks/ui/widgets/app_search.dart';
import 'package:better_breaks/ui/widgets/app_tab_bar.dart';
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
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Column(
            children: [
              // Experience Top Bar with "Experiences for you" heading
              ExperienceTopBar(
                title: 'Experiences for you',
                onBackTap: () {
                  Navigator.pop(context);
                },
              ),

              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: AppSearch(
                  controller: _searchController,
                  onChanged: (value) {
                    // Handle search
                  },
                  onFilterTap: () {
                    // Handle filter tap
                  },
                ),
              ),

              // Tab bar
              AppTabBar(
                tabs: _tabs,
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),

              SizedBox(height: 16.h),

              // Content area (placeholder for now)
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
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
            ],
          ),

          // Bottom navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppBottomNav(
              selectedIndex: _selectedNavIndex,
              onItemSelected: (index) {
                if (index != _selectedNavIndex) {
                  _navigateToPage(index);
                }
              },
            ),
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
