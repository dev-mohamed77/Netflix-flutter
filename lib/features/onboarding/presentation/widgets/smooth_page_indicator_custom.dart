import 'package:flutter/material.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageIndicatorCustom extends StatelessWidget {
  const SmoothPageIndicatorCustom({
    super.key,
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: const ExpandingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        dotColor: AppColorsManager.white,
        activeDotColor: AppColorsManager.accentColor,
      ),
    );
  }
}
