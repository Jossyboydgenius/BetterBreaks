import 'package:flutter/material.dart';
import 'package:better_breaks/data/models/break_models.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'package:better_breaks/ui/views/break_detail/break_detail_view.dart';

class BreakRepository {
  List<RecommendationItem> getRecommendations(BuildContext context) {
    return [
      RecommendationItem(
        dateRange: 'December 27-29',
        description: 'Take 3 days off to get 9 days of holiday',
        isHighImpact: true,
        holidays: ['Christmas', 'New year'],
        onPreviewTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlannerView(),
            ),
          );
        },
      ),
      RecommendationItem(
        dateRange: 'November 10-20',
        description: 'Take 3 days off to get 9 days of holiday',
        isHighImpact: false,
        holidays: ['Salah', 'El-fatir'],
        onPreviewTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlannerView(),
            ),
          );
        },
      ),
      RecommendationItem(
        dateRange: 'May 09-12',
        description: 'Take 3 days off to get 9 days of holiday',
        isHighImpact: false,
        holidays: ['El-fatir', 'Salah'],
        onPreviewTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlannerView(),
            ),
          );
        },
      ),
    ];
  }

  List<BreakItem> getBreaks(BuildContext context) {
    return [
      _createBreakItem(
        context,
        'Summer Vacation',
        'April',
        '24',
        5,
        'Approved',
        50,
        AppColors.lightPurple,
      ),
      _createBreakItem(
        context,
        'Winter Break',
        'Dec',
        '21',
        7,
        'Pending',
        265,
        AppColors.orange100,
      ),
      _createBreakItem(
        context,
        'Spring Break',
        'March',
        '10',
        4,
        'Pending',
        345,
        AppColors.lightGreen,
      ),
    ];
  }

  BreakItem _createBreakItem(
    BuildContext context,
    String title,
    String month,
    String day,
    int days,
    String status,
    int daysRemaining,
    Color cardColor,
  ) {
    return BreakItem(
      title: title,
      month: month,
      day: day,
      days: days,
      status: status,
      daysRemaining: daysRemaining,
      cardColor: cardColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BreakDetailView(breakItem: BreakItem(
              title: title,
              month: month,
              day: day,
              days: days,
              status: status,
              daysRemaining: daysRemaining,
              cardColor: cardColor,
            )),
          ),
        );
      },
    );
  }
} 