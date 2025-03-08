import 'package:flutter/material.dart';
import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';

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
                        index == 0 ? 0.13 :
                        index == 1 ? 0.25 :
                        0.19
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Center(
                          child: AppImages(
                            imagePath: _pages[index].image,
                            width: index == 0 
                                ? 380.w  // Calendar view - make it wider
                                : index == 1 
                                    ? 340.w  // Analytics view
                                    : 340.w,  // Experience view
                            height: index == 0 
                                ? 600.h  // Calendar view - taller for calendar
                                : index == 1 
                                    ? 500.h  // Analytics view
                                    : 550.h,  // Experience view
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
              height: MediaQuery.of(context).size.height * 0.43,
              decoration: BoxDecoration(
                color: _pages[_currentPage].backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 8.w),
                        width: 8.r,
                        height: 8.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      _pages[_currentPage].title,
                      style: AppTextStyle.ralewayExtraBold48.copyWith(
                        color: Colors.white,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      _pages[_currentPage].description,
                      style: AppTextStyle.satoshiRegular20.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.r,
                      right: 24.r,
                      bottom: 24.r,
                      top: 12.r,
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