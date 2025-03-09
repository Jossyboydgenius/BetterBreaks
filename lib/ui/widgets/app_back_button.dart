import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppIcons(
      icon: AppIconData.back,
      size: 14.r,
      color: AppColors.lightBlack,
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
} 