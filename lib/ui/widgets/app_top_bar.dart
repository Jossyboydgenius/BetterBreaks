import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';

class AppTopBar extends StatelessWidget {
  final String heading;
  final String subheading;
  final String icon;
  final VoidCallback? onIconTap;
  final double headingFontSize;
  final double subheadingFontSize;
  final double iconSize;
  final FontWeight headingFontWeight;
  final FontWeight subheadingFontWeight;

  const AppTopBar({
    super.key,
    required this.heading,
    required this.subheading,
    required this.icon,
    this.onIconTap,
    this.headingFontSize = 30,
    this.subheadingFontSize = 28,
    this.iconSize = 24,
    this.headingFontWeight = FontWeight.bold,
    this.subheadingFontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24.w, 
        right: 24.w, 
        top: MediaQuery.of(context).padding.top + 16.h, 
        bottom: 24.h
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: AppTextStyle.play(
                  fontSize: headingFontSize.sp,
                  fontWeight: headingFontWeight,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hi, ',
                      style: AppTextStyle.raleway(
                        fontSize: (subheadingFontSize - 10).sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: subheading.startsWith('Hi, ') 
                          ? subheading.substring(4) 
                          : subheading,
                      style: AppTextStyle.raleway(
                        fontSize: subheadingFontSize.sp,
                        fontWeight: subheadingFontWeight,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onIconTap,
            child: AppIcons(
              icon: icon,
              size: iconSize.r,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
} 