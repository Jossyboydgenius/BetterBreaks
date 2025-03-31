import 'package:flutter/material.dart';

class AppImageData {
  static const _base = 'assets/images';

  // Emoji images
  static const String expressionlessFace = '$_base/expressionless_face.png';
  static const String grinningFace = '$_base/grinning_face_with_smiling_eyes.png';
  static const String relievedFace = '$_base/relieved_face.png';
  static const String sadPensiveFace = '$_base/sad_pensive_face.png';
  static const String smilingFaceWithTear = '$_base/smiling_face_with_tear.png';
  static const String starEyes = '$_base/star_eyes.png';
  static const String sleep = '$_base/sleep.png';
  
  // Other images
  static const String ecoEnergy = '$_base/eco-energy.png';
  static const String planner = '$_base/planner.png';
  static const String sittingWoman = '$_base/sitting-woman-with-open-laptop.png';
  static const String vikingHelmet = '$_base/viking-helmet.png';
  static const String stackBolt = '$_base/stack-bolt.png';
  static const String calendarPlan = '$_base/calendar-plan.png';
  static const String user = '$_base/user.png';
  static const String image = '$_base/image.png';
  static const String image1 = '$_base/image1.png';
  static const String image2 = '$_base/image2.png';
  static const String image3 = '$_base/image3.png';
  static const String image4 = '$_base/image4.png';
  static const String image5 = '$_base/image5.png';
  static const String image6 = '$_base/image6.png';
  static const String image7 = '$_base/image7.png';
  static const String image8 = '$_base/image8.png';
  static const String image9 = '$_base/image9.png';
  static const String image10 = '$_base/image10.png';
  
  
  // Splash and onboarding images
  static const String onboarding1 = '$_base/onboarding1.png';
  static const String onboarding2 = '$_base/onboarding2.png';
  static const String onboarding3 = '$_base/onboarding3.png';
  static const String logo = '$_base/logo.png';
}

class AppImages extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const AppImages({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return _errorWidget();
      },
    );
  }

  Widget _errorWidget() {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.withOpacity(0.4),
      child: const Center(
        child: Icon(
          Icons.image,
          color: Colors.red,
        ),
      ),
    );
  }
} 