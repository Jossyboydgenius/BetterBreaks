import 'dart:async';
import 'package:flutter/material.dart';
import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/shared/app_textstyle.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      NavigationService.pushReplacementNamed(AppRoutes.onboardingView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImageData.logo,
              width: 70,
              height: 70,
            ),
            const SizedBox(height: 6),
            Text(
              'BetterBreaks',
              style: AppTextStyle.redRoseBold32.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 