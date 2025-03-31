import 'package:better_breaks/data/models/break_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/upcoming_breaks_widget.dart';

class BreakDetailView extends StatelessWidget {
  final BreakItem breakItem;

  const BreakDetailView({
    Key? key,
    required this.breakItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(24.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBackButton(
                    color: AppColors.lightBlack,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Break Details',
                    style: AppTextStyle.raleway(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(width: 24.w), // For alignment
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: UpcomingBreaksWidget.detailView(
                breakItem: breakItem,
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: Text(
                'Break Details',
                style: AppTextStyle.raleway(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.r),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailItem('Start Date', 'April 24, 2023'),
                      SizedBox(height: 16.h),
                      _buildDetailItem('End Date', 'April 28, 2023'),
                      SizedBox(height: 16.h),
                      _buildDetailItem('Duration', '5 Days'),
                      SizedBox(height: 16.h),
                      _buildDetailItem('Status', 'Approved'),
                      SizedBox(height: 16.h),
                      _buildDetailItem('Type', 'Vacation'),
                      SizedBox(height: 16.h),
                      _buildDetailItem('Notes', 'Summer vacation with family to Barcelona, Spain'),
                      SizedBox(height: 24.h), // Add extra padding at the bottom
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.grey600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppTextStyle.raleway(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.lightBlack,
          ),
        ),
      ],
    );
  }
} 