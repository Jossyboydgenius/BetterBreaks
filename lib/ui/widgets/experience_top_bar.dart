import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';

class ExperienceTopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;

  const ExperienceTopBar({
    super.key,
    required this.title,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          AppBackButton(
            onPressed: onBackTap,
            color: Colors.white,
            size: 18.r,
          ),

          SizedBox(height: 8.h),

          // Title
          Text(
            title,
            style: AppTextStyle.raleway(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
