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
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? errorText;

  const AppInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffix,
    this.validator,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 48.h,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyle.satoshiRegular20.copyWith(
                color: AppColors.grey600,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              border: InputBorder.none,
              suffixIcon: suffix,
              errorStyle: const TextStyle(height: 0),
            ),
          ),
        ),
        if (errorText != null) ...[
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              top: 4.h,
              bottom: 8.h,
            ),
            child: Text(
              errorText!,
              style: AppTextStyle.satoshiRegular20.copyWith(
                color: AppColors.red,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}