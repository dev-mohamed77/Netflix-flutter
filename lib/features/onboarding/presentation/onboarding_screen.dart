import 'package:flutter/material.dart';
import 'package:netflix/core/components/responsive.dart';
import 'package:netflix/features/onboarding/presentation/widgets/onboarding_body_small.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: OnBoardingBodySmall(),
        web: SizedBox(),
        webSmall: SizedBox(),
      ),
    );
  }
}
