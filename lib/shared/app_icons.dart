// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconData {
  static const String _base = 'assets/svgs';

  // Social icons
  static const String facebook = '$_base/facebook.svg';
  static const String google = '$_base/google.svg';
  static const String apple = '$_base/x.svg';

  // Navigation icons
  static const String back = '$_base/back.svg';
  static const String dashboard = '$_base/dashboard-square.svg';
  static const String settings = '$_base/settings.svg';
  static const String filter = '$_base/filter.svg';
  static const String logout = '$_base/logout.svg';
  static const String close = '$_base/close.svg';

  // Payment icons
  static const String creditCard = '$_base/credit-card.svg';
  static const String payment = '$_base/payment.svg';
  static const String paypal = '$_base/paypal.svg';
  static const String applePay = '$_base/apple-pay.svg';
  static const String googlePay = '$_base/google-pay.svg';

  // Feature icons
  static const String calendar = '$_base/calendar.svg';
  static const String calendar01 = '$_base/calendar-01.svg';
  static const String card = '$_base/card.svg';
  static const String analytics = '$_base/analytics.svg';
  static const String checkList = '$_base/check-list.svg';
  static const String checkmarkBadge = '$_base/checkmark-badge.svg';
  static const String crown = '$_base/crown.svg';
  static const String favourite = '$_base/favourite.svg';
  static const String heavyRain = '$_base/heavy-rain.svg';
  static const String location = '$_base/location.svg';
  static const String location01 = '$_base/location-01.svg';
  static const String lockPassword = '$_base/lock-password.svg';
  static const String lock = '$_base/lock.svg';
  static const String mail = '$_base/mail.svg';
  static const String medal = '$_base/medal.svg';
  static const String notification = '$_base/notification.svg';
  static const String party = '$_base/party.svg';
  static const String pencilEdit = '$_base/pencil-edit.svg';
  static const String search = '$_base/search.svg';
  static const String share = '$_base/share.svg';
  static const String sidebarTop = '$_base/sidebar-top.svg';
  static const String sidebarTop01 = '$_base/sidebar-top-01.svg';
  static const String snow = '$_base/snow.svg';
  static const String sun = '$_base/sun.svg';
  static const String sunny = '$_base/sunny.svg';
  static const String updown = '$_base/updown.svg';
  static const String leftright = '$_base/leftright.svg';
  static const String user = '$_base/user.svg';
  static const String work = '$_base/work.svg';
  static const String zap = '$_base/zap.svg';
  static const String zap01 = '$_base/zap-01.svg';
  static const String zapFilled = '$_base/zap-filled.svg';
  static const String checkMark = '$_base/check-mark.svg';
  static const String success = '$_base/success.svg';
  static const String chevronDown = '$_base/chevron-down.svg';
  static const String check = '$_base/check.svg';
  static const String leftArrow = '$_base/left-arrow.svg';
  static const String rightArrow = '$_base/right-arrow.svg';
  static const String expand = '$_base/expand.svg';
  static const String cloudy = '$_base/cloudy.svg';
  static const String rain = '$_base/rain.svg';
  static const String customerSupport = '$_base/customer-support.svg';
  static const String edit = '$_base/edit.svg';
  static const String message = '$_base/message.svg';
}

class AppIcons extends StatelessWidget {
  final VoidCallback? onPressed;
  final String icon;
  final double size;
  final Color? color;
  const AppIcons({
    super.key,
    this.onPressed,
    this.color,
    required this.icon,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        icon,
        height: size,
        width: size,
        color: color,
      ),
    );
  }
}
