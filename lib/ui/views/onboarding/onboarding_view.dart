import 'package:better_breaks/shared/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Smart Holiday Planning',
      description: 'Maximize your time off with personalized holiday recommendations',
      image: AppImageData.onboarding1,
      backgroundColor: AppColors.primary,
    ),
    OnboardingPage(
      title: 'Analytics & Insights',
      description: 'Track your holiday usage and understand how to reduce stress',
      image: AppImageData.onboarding2,
      backgroundColor: AppColors.primary,
    ),
    OnboardingPage(
      title: 'Seamless Integration',
      description: 'Sync with your calendar, customize preferences, and set blackout dates',
      image: AppImageData.onboarding3,
      backgroundColor: AppColors.primary,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToLogin() {
    NavigationService.pushNamed(AppRoutes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmall = AppDimension.isSmall;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: MediaQuery.of(context).size.height * (
                        isSmall ? 0.15 : 0.20  // Adjust bottom position for small devices
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: isSmall ? 16.w : 24.w),
                        child: Center(
                          child: AppImages(
                            imagePath: _pages[index].image,
                            width: isSmall ? 260.w : 280.w,  // Smaller width for small devices
                            height: isSmall ? 700.h : 700.h,  // Smaller height for small devices
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * (isSmall ? 0.41 : 0.44),  // Smaller height for small devices
              decoration: BoxDecoration(
                color: _pages[_currentPage].backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isSmall ? 20.r : 22.r),
                  topRight: Radius.circular(isSmall ? 20.r : 22.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: isSmall ? 10.h : 20.h),
                  AppDotsIndicator(
                    dotsCount: _pages.length,
                    position: _currentPage,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(height: isSmall ? 16.h : 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isSmall ? 16.w : 24.w),
                    child: Text(
                      _pages[_currentPage].title,
                      style: AppTextStyle.ralewayExtraBold48.copyWith(
                        color: Colors.white,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                        fontSize: isSmall ? 32.sp : 46.sp,  // Smaller font for small devices
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: isSmall ? 8.h : 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isSmall ? 16.w : 24.w),
                    child: Text(
                      _pages[_currentPage].description,
                      style: AppTextStyle.satoshiRegular20.copyWith(
                        color: Colors.white,
                        fontSize: isSmall ? 16.sp : 18.sp,  // Smaller font for small devices
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: isSmall ? 16.r : 24.r,
                      right: isSmall ? 16.r : 24.r,
                      bottom: isSmall ? 16.r : 24.r,
                      top: isSmall ? 8.r : 12.r,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          text: 'Sign Up',
                          backgroundColor: Colors.white,
                          textColor: _pages[_currentPage].backgroundColor,
                          isOutlined: true,
                          onPressed: () {
                            NavigationService.pushNamed(AppRoutes.signUp);
                          },
                        ),
                        SizedBox(height: 12.h),
                        AppTextButton(
                          text: 'Sign In',
                          textColor: Colors.white,
                          onPressed: _navigateToLogin,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}