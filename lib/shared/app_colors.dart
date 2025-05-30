import 'package:flutter/material.dart';

class AppColors {
  // Main colors
  static const Color primary = Color(0xFF009AD6);
  static const Color primaryLight = Color(0xFF1AB9E5);
  static const Color primaryLight100 = Color(0xFFBBF3FF);
  static const Color lightPrimary = Color(0xFFC7EFFF);
  static const Color orange = Color(0xFFFF9A6D);
  static const Color blue100 = Color(0xFF3C6FFF);
  static const Color lightGreen = Color(0xFFB3D069);
  static const Color green = Color(0xFF16A34A);
  static const Color darkGreen = Color(0xFF6C9700);

  // Orange shades
  static const Color orange100 = Color(0xFFFE8D6B);
  static const Color orange200 = Color(0xFFFFDBD0);
  static const Color orange300 = Color(0xFFFF3B30);

  // Green shades
  static const Color lightGreen100 = Color(0xFFDCFCE7);

  // Error/Failure Colors
  static const Color red100 = Color(0xFFDC3545);
  static const Color bgRed100 = Color(0xFFFDF4F5);
  static const Color lightRed100 = Color(0xFFFFE5E7);

  // Success Colors
  static const Color green100 = Color(0xFF198754);
  static const Color bgGreen = Color(0xFFF1F9F5);
  static const Color lightGreen200 = Color(0xFFD1E7DD);

  // Grey shades
  static const Color lightGrey = Color(0xFFA3A3A3);
  static const Color greyLight = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFE2E2E2);
  static const Color grey100 = Color(0xFFF7F8F9);
  static const Color grey200 = Color(0xFFE8ECF4);
  static const Color grey300 = Color(0xFF8391A1);
  static const Color grey400 = Color(0xFFE4E7EB);
  static const Color grey500 = Color(0xFF999DA3);
  static const Color grey600 = Color(0xFF595D62);
  static const Color grey700 = Color(0xFF888888);
  static const Color grey800 = Color(0xFF666666);

  // Black shades
  static const Color lightBlack = Color(0xFF1E232C);
  static const Color lightBlack100 = Color(0xFF4B5563);

  // Background colors
  static const Color background = Color(0xFFCFF7FF);
  static const Color backgroundDark = Color(0xFF102830);

  // Purple shades
  static const Color lightPurple = Color(0xFF7092F2);
  static const Color lightPurple100 = Color(0xFFDEE7FF);

  // Additional colors
  static const Color lightBlue = Color(0xFF00BBFF);
  static const Color blue = Color(0xFF007AFF);
  static const Color indigo = Color(0xFF607BFF);
  static const Color bgIndigo = Color(0xFFF5F7FF);
  static const Color lavender = Color(0xFFEEEAFE);
  static const Color deepPurple = Color(0xFF2E1E98);
  static const Color red = Color(0xFFCB1A14);
  static const Color bgRed = Color(0xFFFBEAE9);
  static const Color lightRed = Color(0xFFF2BCBA);
  static const Color pink = Color(0xFFFFE6EE);
  static const Color amber = Color(0xFFFDB416);
  static const Color darkAmber = Color(0xFFFFBB28);
  static const Color cream = Color(0xFFFFF0E1);
  static const Color royalBlue = Color(0xFF306CB0);
  static const Color paleBlue = Color(0xFFF4F5FF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x99009AD6), // 60% opacity
      Color(0x66009AD6), // 40% opacity
    ],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment(-0.5, 0.5),
    end: Alignment(1, 1),
    colors: [
      Color(0xFF009AD6),
      Color(0xFF6DFFFA),
    ],
    stops: [0.4455, 0.9496],
  );

  // Filter events gradient
  static const LinearGradient filterGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0x99009AD6), // 60% opacity
      Color(0x66009AD6), // 40% opacity
    ],
  );

  // Search field and tab bar gradient
  static const LinearGradient searchFieldGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0x99FFFFFF), // 60% white
      Color(0x66FFFFFF), // 40% white
    ],
  );

  // Selected tab gradient (appealing white with visible gradient)
  static const LinearGradient selectedTabGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white,
      Color(0xFFE1F5FF), // More noticeable blue tint
      Color(0xFFD6F0FF), // Even more noticeable blue tint
    ],
    stops: [0.0, 0.6, 1.0],
  );

  // Box shadow
  static BoxShadow innerShadow = BoxShadow(
    color: const Color(0x40000000), // 40% opacity
    offset: const Offset(5, 4),
    blurRadius: 5.4,
    spreadRadius: -1, // Use negative spread radius to simulate inset
    blurStyle:
        BlurStyle.inner, // Use inner blur style instead of inset parameter
  );

  static const LinearGradient calendarBorderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x6EBDBDBD), // rgba(189, 189, 189, 0.43)
      Color(0x99FFFFFF), // rgba(255, 255, 255, 0.6)
    ],
  );

  static const LinearGradient weatherIndicatorGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFEA4335), // #EA4335
      Color(0xFFFBBC04), // #FBBC04
    ],
  );

  // Premium features gradient
  static const LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF009AD6),
      Color(0xFF6DFFFA),
    ],
    stops: [0.5, 1.0],
  );
}
