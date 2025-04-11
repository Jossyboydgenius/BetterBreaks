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

class Event {
  final String image;
  final String title;
  final String location;
  final String date;
  final String price;
  final bool isFullWidth;
  final List<String> categories;
  final bool isTopPick;
  final String? description;
  final VoidCallback? onTap;

  const Event({
    required this.image,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    this.isFullWidth = false,
    required this.categories,
    this.isTopPick = false,
    this.description,
    this.onTap,
  });

  // Convert from a Map (useful for JSON parsing)
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      date: map['date'] ?? '',
      price: map['price'] ?? '',
      isFullWidth: map['fullWidth'] == 'true',
      categories: List<String>.from(map['categories'] ?? []),
      isTopPick: map['isTopPick'] ?? false,
      description: map['description'],
    );
  }

  // Convert to a Map (useful for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'location': location,
      'date': date,
      'price': price,
      'fullWidth': isFullWidth ? 'true' : 'false',
      'categories': categories,
      'isTopPick': isTopPick,
      if (description != null) 'description': description,
    };
  }

  Event copyWith({
    String? image,
    String? title,
    String? location,
    String? date,
    String? price,
    bool? isFullWidth,
    List<String>? categories,
    bool? isTopPick,
    String? description,
    VoidCallback? onTap,
  }) {
    return Event(
      image: image ?? this.image,
      title: title ?? this.title,
      location: location ?? this.location,
      date: date ?? this.date,
      price: price ?? this.price,
      isFullWidth: isFullWidth ?? this.isFullWidth,
      categories: categories ?? this.categories,
      isTopPick: isTopPick ?? this.isTopPick,
      description: description ?? this.description,
      onTap: onTap ?? this.onTap,
    );
  }
}
