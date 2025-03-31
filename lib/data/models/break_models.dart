import 'package:flutter/material.dart';

class BreakItem {
  final String title;
  final String month;
  final String day;
  final int days;
  final String status;
  final int daysRemaining;
  final Color cardColor;
  final VoidCallback? onTap;

  const BreakItem({
    required this.title,
    required this.month,
    required this.day,
    required this.days,
    required this.status,
    required this.daysRemaining,
    required this.cardColor,
    this.onTap,
  });

  BreakItem copyWith({
    String? title,
    String? month,
    String? day,
    int? days,
    String? status,
    int? daysRemaining,
    Color? cardColor,
    VoidCallback? onTap,
  }) {
    return BreakItem(
      title: title ?? this.title,
      month: month ?? this.month,
      day: day ?? this.day,
      days: days ?? this.days,
      status: status ?? this.status,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      cardColor: cardColor ?? this.cardColor,
      onTap: onTap ?? this.onTap,
    );
  }
}

class RecommendationItem {
  final String dateRange;
  final String description;
  final bool isHighImpact;
  final List<String> holidays;
  final VoidCallback? onPreviewTap;

  const RecommendationItem({
    required this.dateRange,
    required this.description,
    required this.isHighImpact,
    required this.holidays,
    this.onPreviewTap,
  });

  RecommendationItem copyWith({
    String? dateRange,
    String? description,
    bool? isHighImpact,
    List<String>? holidays,
    VoidCallback? onPreviewTap,
  }) {
    return RecommendationItem(
      dateRange: dateRange ?? this.dateRange,
      description: description ?? this.description,
      isHighImpact: isHighImpact ?? this.isHighImpact,
      holidays: holidays ?? this.holidays,
      onPreviewTap: onPreviewTap ?? this.onPreviewTap,
    );
  }
} 