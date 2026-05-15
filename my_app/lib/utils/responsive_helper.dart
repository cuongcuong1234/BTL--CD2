import 'package:flutter/material.dart';

class ResponsiveHelper {
  // Breakpoints
  static const double mobileMax = 600;
  static const double tabletMax = 1200;

  // Device type
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= mobileMax;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > mobileMax && 
           MediaQuery.of(context).size.width <= tabletMax;
  }

  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width > tabletMax;
  }

  // Font sizes
  static double titleFontSize(BuildContext context) {
    if (isMobile(context)) return 20;
    if (isTablet(context)) return 24;
    return 28;
  }

  static double headingFontSize(BuildContext context) {
    if (isMobile(context)) return 18;
    if (isTablet(context)) return 22;
    return 26;
  }

  static double subheadingFontSize(BuildContext context) {
    if (isMobile(context)) return 14;
    if (isTablet(context)) return 16;
    return 18;
  }

  static double bodyFontSize(BuildContext context) {
    if (isMobile(context)) return 12;
    if (isTablet(context)) return 14;
    return 16;
  }

  static double smallFontSize(BuildContext context) {
    if (isMobile(context)) return 10;
    if (isTablet(context)) return 12;
    return 14;
  }

  // Icon sizes
  static double largeIconSize(BuildContext context) {
    if (isMobile(context)) return 40;
    if (isTablet(context)) return 50;
    return 60;
  }

  static double mediumIconSize(BuildContext context) {
    if (isMobile(context)) return 32;
    if (isTablet(context)) return 40;
    return 48;
  }

  static double smallIconSize(BuildContext context) {
    if (isMobile(context)) return 20;
    if (isTablet(context)) return 24;
    return 28;
  }

  // Padding and margins
  static double paddingXSmall(BuildContext context) {
    if (isMobile(context)) return 4;
    if (isTablet(context)) return 6;
    return 8;
  }

  static double paddingSmall(BuildContext context) {
    if (isMobile(context)) return 8;
    if (isTablet(context)) return 12;
    return 16;
  }

  static double paddingMedium(BuildContext context) {
    if (isMobile(context)) return 12;
    if (isTablet(context)) return 16;
    return 20;
  }

  static double paddingLarge(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 20;
    return 24;
  }

  static double paddingXLarge(BuildContext context) {
    if (isMobile(context)) return 20;
    if (isTablet(context)) return 24;
    return 32;
  }

  // Grid crossAxisCount
  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 3;
    return 4;
  }

  static int getGridCrossAxisCountLarge(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 4;
    return 6;
  }

  // Border radius
  static double borderRadiusSmall(BuildContext context) {
    if (isMobile(context)) return 4;
    if (isTablet(context)) return 6;
    return 8;
  }

  static double borderRadiusMedium(BuildContext context) {
    if (isMobile(context)) return 8;
    if (isTablet(context)) return 12;
    return 16;
  }

  static double borderRadiusLarge(BuildContext context) {
    if (isMobile(context)) return 12;
    if (isTablet(context)) return 16;
    return 20;
  }

  // Width constraints
  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return MediaQuery.of(context).size.width;
    if (isTablet(context)) return 1000;
    return 1400;
  }

  // Dialog width
  static double getDialogWidth(BuildContext context) {
    if (isMobile(context)) return MediaQuery.of(context).size.width * 0.9;
    if (isTablet(context)) return 600;
    return 700;
  }

  // Card width
  static double getCardWidth(BuildContext context) {
    if (isMobile(context)) return MediaQuery.of(context).size.width - 32;
    if (isTablet(context)) return 400;
    return 500;
  }

  // Avatar radius
  static double getAvatarRadius(BuildContext context) {
    if (isMobile(context)) return 30;
    if (isTablet(context)) return 40;
    return 50;
  }

  // AppBar height
  static double getAppBarHeight(BuildContext context) {
    if (isMobile(context)) return 56;
    if (isTablet(context)) return 64;
    return 72;
  }

  // Screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // Orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Spacing helpers
  static SizedBox verticalSpace(BuildContext context, {double ratio = 1.0}) {
    return SizedBox(height: paddingMedium(context) * ratio);
  }

  static SizedBox horizontalSpace(BuildContext context, {double ratio = 1.0}) {
    return SizedBox(width: paddingMedium(context) * ratio);
  }
}
