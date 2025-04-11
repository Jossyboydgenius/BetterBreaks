import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class AddCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassyContainer(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            // Plus icon in circle
            Container(
              width: 40.r,
              height: 40.r,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 24.r,
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              'Add New Payment Card',
              style: AppTextStyle.satoshi(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
