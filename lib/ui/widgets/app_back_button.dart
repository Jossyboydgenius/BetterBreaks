import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/app/theme_handler.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? size;
  final Color? color;

  const AppBackButton({
    super.key,
    this.onPressed,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AppIcons(
        icon: AppIconData.back,
        size: size ?? 16.r,
        color:
            color ?? (context.isDarkMode ? Colors.white : AppColors.lightBlack),
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
      iconSize: 24.r,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
    );
  }
}
