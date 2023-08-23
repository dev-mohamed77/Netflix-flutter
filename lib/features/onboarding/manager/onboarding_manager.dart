import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/onboarding_model.dart';

final List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    title: "Welcome To Netflix",
    subTitle:
        "The best movies streaming app of the century to make your days great !",
  ),
  OnBoardingModel(
    title: "Welcome To Netflix",
    subTitle:
        "The best movies streaming app of the century to make your days great !",
  ),
  OnBoardingModel(
    title: "Welcome To Netflix",
    subTitle:
        "The best movies streaming app of the century to make your days great !",
  ),
];

final onBoardingDataProvider =
    Provider<List<OnBoardingModel>>((ref) => onBoardingData);
