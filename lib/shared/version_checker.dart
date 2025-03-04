import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionChecker {
  static Future<String> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      debugPrint('Error getting app version: $e');
      return '1.0.0';
    }
  }

  static Future<String> getBuildNumber() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.buildNumber;
    } catch (e) {
      debugPrint('Error getting build number: $e');
      return '1';
    }
  }

  static Future<String> getFullVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return '${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (e) {
      debugPrint('Error getting full version: $e');
      return '1.0.0+1';
    }
  }
} 