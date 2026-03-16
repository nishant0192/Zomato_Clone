import 'package:flutter/material.dart';

class Responsive {
  static const double mobileMaxWidth = 600;
  static const double tabletMinWidth = 600;
  static const double tabletMaxWidth = 1200;
  static const double desktopMinWidth = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletMinWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMinWidth &&
      MediaQuery.of(context).size.width < desktopMinWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopMinWidth;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getDynamicWidth(
    BuildContext context, {
    double mobilePercent = 0.9,
    double tabletPercent = 0.85,
    double desktopPercent = 0.8,
  }) {
    final width = screenWidth(context);
    if (isMobile(context)) {
      return width * mobilePercent;
    } else if (isTablet(context)) {
      return width * tabletPercent;
    } else {
      return width * desktopPercent;
    }
  }

  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return 1;
    } else if (isTablet(context)) {
      return 2;
    } else {
      return 3;
    }
  }

  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    double mobile = 16,
    double tablet = 24,
    double desktop = 32,
  }) {
    if (isMobile(context)) {
      return EdgeInsets.all(mobile);
    } else if (isTablet(context)) {
      return EdgeInsets.all(tablet);
    } else {
      return EdgeInsets.all(desktop);
    }
  }
}
