import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/setup_bottom_sheet.dart';

class LeavePreferenceSection extends StatelessWidget {
  final VoidCallback onSetupComplete;

  const LeavePreferenceSection({
    super.key,
    required this.onSetupComplete,
  });

  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Are you making the most of your breaks?',
            style: AppTextStyle.raleway(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'How well you have planned your breaks',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          AppImages(
            imagePath: AppImageData.calendarPlan,
            width: 150.w,
            height: 150.h,
          ),
          SizedBox(height: 16.h),
          Text(
            'Set up your leave preference so you can see detailed analysis',
            style: AppTextStyle.satoshi(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack100,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          AppButton(
            text: 'Set up',
            backgroundColor: AppColors.primary,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                builder: (context) => SetupBottomSheet(
                  onComplete: () {
                    Navigator.pop(context);
                    onSetupComplete();
                  },
                ),
              );
            },
            height: 44.h,
          ),
        ],
      ),
    );
  }
} 