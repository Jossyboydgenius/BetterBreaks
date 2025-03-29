import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'dart:ui';

class EventDetailsView extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String date;
  final String price;

  const EventDetailsView({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppImages(
                  imagePath: image,
                  width: double.infinity,
                  height: 300.h,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: AppBackButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and basic info
                        Text(
                          title,
                          style: AppTextStyle.raleway(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightBlack,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildInfoRow(AppIconData.location01, location),
                        SizedBox(height: 8.h),
                        _buildInfoRow(AppIconData.calendar01, date),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Price',
                                  style: AppTextStyle.satoshi(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey800,
                                  ),
                                ),
                                Text(
                                  price,
                                  style: AppTextStyle.satoshi(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        // Divider
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        SizedBox(height: 24.h),
                        // About section
                        Text(
                          'About the event',
                          style: AppTextStyle.raleway(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.lightBlack,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Neque semper ultrices tempor facilisi viverra. Tellus congue id lacinia leo rutrum tellus. Quis quis eget volutpat sapien faucibus quam lacus in fermentum.',
                          style: AppTextStyle.satoshi(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey800,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Location section
                        Text(
                          'Location',
                          style: AppTextStyle.raleway(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.lightBlack,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            AppIcons(
                              icon: AppIconData.location01,
                              size: 20.r,
                              color: AppColors.grey800,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                location,
                                style: AppTextStyle.satoshi(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String icon, String text) {
    return Row(
      children: [
        AppIcons(
          icon: icon,
          size: 20.r,
          color: AppColors.grey800,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.grey800,
            ),
          ),
        ),
      ],
    );
  }
} 