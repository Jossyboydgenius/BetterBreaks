import 'package:flutter/material.dart';
import 'package:better_breaks/ui/widgets/suggestion_card.dart';
import 'package:better_breaks/ui/views/setup/setup_planner_view.dart';

class SuggestionsContent extends StatelessWidget {
  final VoidCallback? onBack;

  const SuggestionsContent({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SuggestionCard(
          dateRange: 'December 27-29',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: true,
          holidays: ['Christmas', 'New year'],
          onPreviewTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SetupPlannerView(
                  onBack: onBack,
                ),
              ),
            );
          },
        ),
        SuggestionCard(
          dateRange: 'November 10-20',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: false,
          holidays: ['Salah', 'El-fatir'],
          onPreviewTap: () {
            // Handle preview tap
          },
        ),
        SuggestionCard(
          dateRange: 'May 09-12',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: false,
          holidays: ['El-fatir', 'Salah'],
          onPreviewTap: () {
            // Handle preview tap
          },
        ),
        SuggestionCard(
          dateRange: 'May 09-12',
          description: 'Take 3 days off to get 9 days of holiday',
          isHighImpact: false,
          holidays: ['El-fatir', 'Salah'],
          onPreviewTap: () {
            // Handle preview tap
          },
        ),
      ],
    );
  }
}
