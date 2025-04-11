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

  // Sample event data - using existing images from assets with added categories
  final List<Map<String, dynamic>> _events = [
    {
      'image': AppImageData.image3,
      'title': 'Jazz Night at The Blue Note',
      'location': 'The Blue Note, London',
      'date': 'Fri, 15 Jul • 8:00 PM',
      'price': '£25',
      'fullWidth': 'true',
      'categories': ['Top picks', 'Music'],
      'isTopPick': true,
    },
    {
      'image': AppImageData.image4,
      'title': 'Art Exhibition: Modern Masters',
      'location': 'National Gallery, London',
      'date': 'Sat, 16 Jul • 10:00 AM',
      'price': '£15',
      'fullWidth': 'false',
      'categories': ['All'],
      'isTopPick': false,
    },
    {
      'image': AppImageData.image5,
      'title': 'Yoga in the Park',
      'location': 'Hyde Park, London',
      'date': 'Sun, 17 Jul • 9:00 AM',
      'price': '£10',
      'fullWidth': 'false',
      'categories': ['Health'],
      'isTopPick': true,
    },
    {
      'image': AppImageData.image6,
      'title': 'Food Festival',
      'location': 'Southbank Centre, London',
      'date': 'Sat, 23 Jul • 11:00 AM',
      'price': '£20',
      'fullWidth': 'true',
      'categories': ['All', 'Top picks'],
      'isTopPick': true,
    },
    {
      'image': AppImageData.image7,
      'title': 'Photography Workshop',
      'location': 'Tate Modern, London',
      'date': 'Sun, 30 Jul • 2:00 PM',
      'price': '£30',
      'fullWidth': 'false',
      'categories': ['All'],
      'isTopPick': false,
    },
    {
      'image': AppImageData.image8,
      'title': 'Comedy Night',
      'location': 'The Comedy Store, London',
      'date': 'Fri, 21 Jul • 7:30 PM',
      'price': '£18',
      'fullWidth': 'false',
      'categories': ['All'],
      'isTopPick': false,
    },
    {
      'image': AppImageData.image1,
      'title': 'New Blockbuster Premiere',
      'location': 'Picturehouse Cinema, London',
      'date': 'Thu, 20 Jul • 7:00 PM',
      'price': '£18',
      'fullWidth': 'true',
      'categories': ['Movies', 'Top picks'],
      'isTopPick': true,
    },
    {
      'image': AppImageData.image2,
      'title': 'Indie Film Festival',
      'location': 'BFI Southbank, London',
      'date': 'Sat, 22 Jul • All Day',
      'price': '£45',
      'fullWidth': 'false',
      'categories': ['Movies'],
      'isTopPick': false,
    },
    {
      'image': AppImageData.image3,
      'title': 'Classical Music Concert',
      'location': 'Royal Albert Hall, London',
      'date': 'Sun, 23 Jul • 7:30 PM',
      'price': '£35',
      'fullWidth': 'false',
      'categories': ['Music'],
      'isTopPick': false,
    },
    {
      'image': AppImageData.image4,
      'title': 'Wellness Retreat Day',
      'location': 'The Shard, London',
      'date': 'Sat, 29 Jul • 10:00 AM',
      'price': '£80',
      'fullWidth': 'true',
      'categories': ['Health'],
      'isTopPick': true,
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
                  setState(() {
                    // Rebuild UI when search text changes
                  });
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
    // Filter events based on selected tab
    List<Map<String, dynamic>> filteredEvents = _filterEventsByTab();

    // Filter by search text if search is not empty
    if (_searchController.text.isNotEmpty) {
      final searchText = _searchController.text.toLowerCase();
      filteredEvents = filteredEvents.where((event) {
        return event['title'].toString().toLowerCase().contains(searchText) ||
            event['location'].toString().toLowerCase().contains(searchText);
      }).toList();
    }

    // If no events match filters, show a message
    if (filteredEvents.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Text(
            'No events found',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
          ),
        ),
      );
    }

    // Create a list of widgets containing both full-width and half-width cards
    final List<Widget> rows = [];

    for (int i = 0; i < filteredEvents.length; i++) {
      final event = filteredEvents[i];
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
        if (i + 1 < filteredEvents.length &&
            filteredEvents[i + 1]['fullWidth'] != 'true') {
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
                      image: filteredEvents[i + 1]['image']!,
                      title: filteredEvents[i + 1]['title']!,
                      location: filteredEvents[i + 1]['location']!,
                      date: filteredEvents[i + 1]['date']!,
                      price: filteredEvents[i + 1]['price']!,
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

  // Filter events based on selected tab
  List<Map<String, dynamic>> _filterEventsByTab() {
    final selectedCategory = _tabs[_selectedTabIndex];

    if (selectedCategory == 'All') {
      // Return all events for the "All" tab
      return _events;
    } else if (selectedCategory == 'Top picks') {
      // Return only top picks
      return _events.where((event) => event['isTopPick'] == true).toList();
    } else {
      // Filter by category for other tabs
      return _events.where((event) {
        List<String> categories = List<String>.from(event['categories']);
        return categories.contains(selectedCategory);
      }).toList();
    }
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
    if (index == 3) {
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
