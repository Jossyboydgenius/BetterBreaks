import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final BoxShadow? customShadow;

  const SectionContainer({
    super.key,
    required this.child,
    this.customShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          customShadow ??
              BoxShadow(
                color: AppThemeColors.getShadowColor(context),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
        ],
      ),
      child: GlassyContainer(
        backgroundColor: AppThemeColors.getCardColor(context),
        borderColor: AppThemeColors.getDividerColor(context),
        padding: EdgeInsets.all(24.r),
        child: child,
      ),
    );
  }
}
