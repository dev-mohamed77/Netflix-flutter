import 'package:flutter/material.dart';
import 'package:netflix/core/utility/platform_info.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.web,
    required this.webSmall,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget web;
  final Widget webSmall;

  static bool isMobile(context) => MediaQuery.sizeOf(context).width <= 600;
  static bool isTablet(context) =>
      MediaQuery.sizeOf(context).width <= 950 &&
      MediaQuery.sizeOf(context).width > 600;

  static bool isWeb(context) => MediaQuery.sizeOf(context).width > 950;

  @override
  Widget build(BuildContext context) {
    if (PlatFormInfo.isWeb() || PlatFormInfo.isDesktopOs()) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 950) {
            return web;
          } else if (constraints.maxWidth >= 600 && tablet != null) {
            return tablet!;
          } else {
            return webSmall;
          }
        },
      );
    } else if (PlatFormInfo.isMobileOs()) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600 && tablet != null) {
            return tablet!;
          } else {
            return mobile;
          }
        },
      );
    } else {
      return const Center(
        child: Text("The system is unknown"),
      );
    }
  }
}
