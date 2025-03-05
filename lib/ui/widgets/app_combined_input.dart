import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class AppCombinedInput extends StatelessWidget {
  final List<AppInputField> fields;

  const AppCombinedInput({
    super.key,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        children: List.generate(
          fields.length * 2 - 1,
          (index) {
            if (index.isOdd) {
              return Divider(height: 1, thickness: 1, color: AppColors.grey);
            }
            return fields[index ~/ 2];
          },
        ),
      ),
    );
  }
}

class AppInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffix;

  const AppInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.satoshiRegular20.copyWith(
            color: AppColors.grey600,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          border: InputBorder.none,
          suffixIcon: suffix,
        ),
      ),
    );
  }
} 