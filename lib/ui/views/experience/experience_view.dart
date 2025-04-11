import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/ui/widgets/app_bottom_nav.dart';
import 'package:better_breaks/ui/widgets/experience_top_bar.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/widgets/event_card.dart';
import 'package:better_breaks/data/models/break_models.dart';
import 'package:better_breaks/data/repositories/event_repository.dart';
import 'package:better_breaks/ui/widgets/filter_events_bottom_sheet.dart';

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

  // Event repository instance
  final EventRepository _eventRepository = EventRepository();

  // List to store filtered events
  late List<Event> _filteredEvents;

  // Filter parameters
  String? _locationFilter;
  DateTime? _startDateFilter;
  DateTime? _endDateFilter;
  double? _minPriceFilter;
  double? _maxPriceFilter;

  @override
  void initState() {
    super.initState();
    _filteredEvents =
        _eventRepository.getEventsByCategory(_tabs[_selectedTabIndex]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: FilterEventsBottomSheet(
            onApplyFilter: (filterData) {
              setState(() {
                _locationFilter = filterData['location'];
                _startDateFilter = filterData['startDate'];
                _endDateFilter = filterData['endDate'];
                _minPriceFilter = filterData['minPrice'];
                _maxPriceFilter = filterData['maxPrice'];

                // Apply all filters at once
                _updateFilteredEvents();
              });
            },
          ),
        );
      },
    );
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
                    // Filter by search text
                    _updateFilteredEvents();
                  });
                },
                onFilterTap: _showFilterBottomSheet,
                tabs: _tabs,
                selectedTabIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                    _updateFilteredEvents();
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

  // Update the filtered events based on selected tab, search text, and filters
  void _updateFilteredEvents() {
    // First get events filtered by category
    List<Event> events =
        _eventRepository.getEventsByCategory(_tabs[_selectedTabIndex]);

    // Apply search filter if text is not empty
    if (_searchController.text.isNotEmpty) {
      final searchText = _searchController.text.toLowerCase();
      events = events.where((event) {
        return event.title.toLowerCase().contains(searchText) ||
            event.location.toLowerCase().contains(searchText);
      }).toList();
    }

    // Apply location filter
    if (_locationFilter != null && _locationFilter!.isNotEmpty) {
      events = events.where((event) {
        return event.location
            .toLowerCase()
            .contains(_locationFilter!.toLowerCase());
      }).toList();
    }

    // Apply date range filter
    if (_startDateFilter != null && _endDateFilter != null) {
      // This is a simplified implementation since we'd need to parse the date strings
      // For a real implementation, we'd need to convert event.date to DateTime
      // and compare with _startDateFilter and _endDateFilter
    }

    // Apply price filter
    if (_minPriceFilter != null && _maxPriceFilter != null) {
      events = events.where((event) {
        // Extract numeric price value from string (e.g. '£25' → 25)
        final priceStr = event.price.replaceAll(RegExp(r'[^0-9]'), '');
        if (priceStr.isEmpty) return false;

        final price = double.parse(priceStr);
        return price >= _minPriceFilter! && price <= _maxPriceFilter!;
      }).toList();
    }

    setState(() {
      _filteredEvents = events;
    });
  }

  Widget _buildEventsList() {
    // If no events match filters, show a message
    if (_filteredEvents.isEmpty) {
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

    for (int i = 0; i < _filteredEvents.length; i++) {
      final event = _filteredEvents[i];
      final isFullWidth = event.isFullWidth;

      if (isFullWidth) {
        // Add full-width card
        rows.add(
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: EventCard(
              image: event.image,
              title: event.title,
              location: event.location,
              date: event.date,
              price: event.price,
              description: event.description,
              useGradientOverlay: true,
              isFullWidth: true,
            ),
          ),
        );
      } else {
        // Add half-width card, possibly pairing with the next item
        if (i + 1 < _filteredEvents.length &&
            !_filteredEvents[i + 1].isFullWidth) {
          // We have two half-width cards to display in a row
          rows.add(
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Expanded(
                    child: EventCard(
                      image: event.image,
                      title: event.title,
                      location: event.location,
                      date: event.date,
                      price: event.price,
                      description: event.description,
                      useGradientOverlay: true,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: EventCard(
                      image: _filteredEvents[i + 1].image,
                      title: _filteredEvents[i + 1].title,
                      location: _filteredEvents[i + 1].location,
                      date: _filteredEvents[i + 1].date,
                      price: _filteredEvents[i + 1].price,
                      description: _filteredEvents[i + 1].description,
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
                image: event.image,
                title: event.title,
                location: event.location,
                date: event.date,
                price: event.price,
                description: event.description,
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
