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
  
  // Other images
  static const String ecoEnergy = '$_base/eco-energy.png';
  static const String planner = '$_base/planner.png';
  static const String sittingWoman = '$_base/sitting-woman-with-open-laptop.png';
  static const String vikingHelmet = '$_base/viking-helmet.png';
  
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