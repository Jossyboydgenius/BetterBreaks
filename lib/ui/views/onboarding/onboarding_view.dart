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
      image: AppImageData.onboarding3,
      backgroundColor: AppColors.orange,
    ),
    OnboardingPage(
      title: 'Seamless Integration',
      description: 'Sync with your calendar, customize preferences, and set blackout dates',
      image: AppImageData.onboarding2,
      backgroundColor: AppColors.lightGreen,
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
      body: Stack(
        children: [
          // Full screen PageView for images
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return Image.asset(
                _pages[index].image,
                fit: BoxFit.cover,
              );
            },
          ),
          // Bottom sheet content
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
                  // Centered page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the dots
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
                  SizedBox(height: 20.h), // Reduced spacing
                  // Title with reduced line spacing
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      _pages[_currentPage].title,
                      style: AppTextStyle.ralewayExtraBold48.copyWith(
                        color: Colors.white,
                        height: 1.1, // Reduced line height for title
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 12.h), // Reduced spacing
                  // Description
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
                  // Buttons
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.r,
                      right: 24.r,
                      bottom: 24.r,
                      top: 12.r, // Reduced top padding
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use minimum space
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