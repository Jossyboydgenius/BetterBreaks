import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'dart:ui';
import 'package:better_breaks/ui/views/event_details/event_details_view.dart';

class EventCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String date;
  final String price;

  const EventCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
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
            ),
          ),
        );
      },
      child: Container(
        height: 240.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
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
                    // White separator line
                    Container(
                      height: 2.h,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                          padding: EdgeInsets.all(16.r),
                          color: Colors.white.withOpacity(0.15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                title,
                                style: AppTextStyle.raleway(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              // SizedBox(height: 4.h),
                              
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
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: Text(
                                            location,
                                            style: AppTextStyle.satoshi(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
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
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              
                              // SizedBox(height: 14.h),
                              
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
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          date,
                                          style: AppTextStyle.satoshi(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
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
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
} 