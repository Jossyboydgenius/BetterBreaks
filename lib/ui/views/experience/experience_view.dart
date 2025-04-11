import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/experience_top_bar.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/widgets/event_card.dart';
import 'package:better_breaks/shared/app_images.dart';

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

  // Sample event data - using existing images from assets
  final List<Map<String, String>> _events = [
    {
      'image': AppImageData.image3,
      'title': 'Jazz Night at The Blue Note',
      'location': 'The Blue Note, London',
      'date': 'Fri, 15 Jul • 8:00 PM',
      'price': '£25',
      'fullWidth': 'true',
    },
    {
      'image': AppImageData.image4,
      'title': 'Art Exhibition: Modern Masters',
      'location': 'National Gallery, London',
      'date': 'Sat, 16 Jul • 10:00 AM',
      'price': '£15',
      'fullWidth': 'false',
    },
    {
      'image': AppImageData.image5,
      'title': 'Yoga in the Park',
      'location': 'Hyde Park, London',
      'date': 'Sun, 17 Jul • 9:00 AM',
      'price': '£10',
      'fullWidth': 'false',
    },
    {
      'image': AppImageData.image6,
      'title': 'Food Festival',
      'location': 'Southbank Centre, London',
      'date': 'Sat, 23 Jul • 11:00 AM',
      'price': '£20',
      'fullWidth': 'true',
    },
    {
      'image': AppImageData.image7,
      'title': 'Photography Workshop',
      'location': 'Tate Modern, London',
      'date': 'Sun, 30 Jul • 2:00 PM',
      'price': '£30',
      'fullWidth': 'false',
    },
    {
      'image': AppImageData.image8,
      'title': 'Comedy Night',
      'location': 'The Comedy Store, London',
      'date': 'Fri, 21 Jul • 7:30 PM',
      'price': '£18',
      'fullWidth': 'false',
    },
    {
      'image': AppImageData.image4,
      'title': 'Chelsea\'s Match',
      'location': 'Gelora Bung Karno Stadium',
      'date': 'November 15 2023',
      'price': '\$60',
      'fullWidth': 'false',
    },
  ];

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
              // Experience Top Bar
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

              // Expanded content area with scroll
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Content container with rounded corners
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightPrimary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(24.r),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                        child: _buildEventsList(),
                      ),
                      // Bottom padding to prevent content from being hidden behind bottom nav
                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom navigation - positioned at the bottom of the stack
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

  Widget _buildEventsList() {
    // Create a list of widgets containing both full-width and half-width cards
    final List<Widget> rows = [];

    for (int i = 0; i < _events.length; i++) {
      final event = _events[i];
      final isFullWidth = event['fullWidth'] == 'true';

      if (isFullWidth) {
        // Add full-width card
        rows.add(
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: EventCard(
              image: event['image']!,
              title: event['title']!,
              location: event['location']!,
              date: event['date']!,
              price: event['price']!,
              useGradientOverlay: true,
              isFullWidth: true,
            ),
          ),
        );
      } else {
        // Add half-width card, possibly pairing with the next item
        if (i + 1 < _events.length && _events[i + 1]['fullWidth'] != 'true') {
          // We have two half-width cards to display in a row
          rows.add(
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Expanded(
                    child: EventCard(
                      image: event['image']!,
                      title: event['title']!,
                      location: event['location']!,
                      date: event['date']!,
                      price: event['price']!,
                      useGradientOverlay: true,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: EventCard(
                      image: _events[i + 1]['image']!,
                      title: _events[i + 1]['title']!,
                      location: _events[i + 1]['location']!,
                      date: _events[i + 1]['date']!,
                      price: _events[i + 1]['price']!,
                      useGradientOverlay: true,
                    ),
                  ),
                ],
              ),
            ),
          );

          // Skip the next item since we already used it
          i++;
        } else {
          // Just one half-width card, display it as full-width
          rows.add(
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: EventCard(
                image: event['image']!,
                title: event['title']!,
                location: event['location']!,
                date: event['date']!,
                price: event['price']!,
                useGradientOverlay: true,
                isFullWidth: true,
              ),
            ),
          );
        }
      }
    }

    return Column(
      children: rows,
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
    if (index == 1) {
      // Navigate to Planner
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PlannerView(
            isSetup: false,
            showBottomNav: true,
          ),
        ),
      );
    }
    if (index == 2) {
      // Navigate to Analytics
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AnalyticsView(),
        ),
      );
    }
  }
}
