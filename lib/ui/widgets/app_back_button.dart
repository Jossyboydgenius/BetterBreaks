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
        size: size ?? 14.r, // Reduced size from 16 to 14
        color:
            color ?? (context.isDarkMode ? Colors.white : AppColors.lightBlack),
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
      iconSize: 22.r, // Reduced size from 24 to 22
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
