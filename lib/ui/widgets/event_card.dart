import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'dart:ui';
import 'package:better_breaks/ui/views/event_details/event_details_view.dart';

class EventCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String date;
  final String price;
  final bool useGradientOverlay;
  final bool isFullWidth;
  final String? description;

  const EventCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    this.useGradientOverlay = false,
    this.isFullWidth = false,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsView(
              image: image,
              title: title,
              location: location,
              date: date,
              price: price,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        height: 240.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white.withOpacity(0.4)
                : AppThemeColors.getDividerColor(context),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Background image
              AppImages(
                imagePath: image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),

              // Content overlay
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    if (useGradientOverlay)
                      // Gradient black overlay
                      Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.9),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                        child: _buildCardContent(context),
                      )
                    else
                      // Glass blur effect
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                          child: Container(
                            padding: EdgeInsets.all(16.r),
                            color: (Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(0.15),
                            child: _buildCardContent(context),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    // Always use white text on image overlays for better readability, regardless of theme
    const Color contentColor = Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: AppTextStyle.raleway(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: contentColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),

        // Location and Price label in a row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and icon
            Expanded(
              child: Row(
                children: [
                  AppIcons(
                    icon: AppIconData.location01,
                    size: 14.r,
                    color: contentColor,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      location,
                      style: AppTextStyle.satoshi(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: contentColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Price label (right aligned)
            Text(
              'Price',
              style: AppTextStyle.satoshi(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: contentColor,
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        // Date and Price value in a row
        Row(
          children: [
            // Date
            Expanded(
              child: Row(
                children: [
                  AppIcons(
                    icon: AppIconData.calendar01,
                    size: 14.r,
                    color: contentColor,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      date,
                      style: AppTextStyle.satoshi(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: contentColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Price value
            Text(
              price,
              style: AppTextStyle.interVariable(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: contentColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
