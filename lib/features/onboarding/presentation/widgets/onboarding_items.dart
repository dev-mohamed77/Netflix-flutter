import 'package:flutter/material.dart';

import '../../model/onboarding_model.dart';

class OnBoardingItems extends StatelessWidget {
  const OnBoardingItems({super.key, required this.model});

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            model.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.subTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
