import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/onboarding/manager/onboarding_manager.dart';
import 'package:netflix/features/onboarding/presentation/widgets/smooth_page_indicator_custom.dart';
import '../../../../core/components/background_image_custom.dart';
import '../../../../core/components/button_custom.dart';
import '../../../../core/config/app_assets_config.dart';
import '../../../../core/manager/color/colors_manager.dart';
import 'onboarding_items.dart';

class OnBoardingBodySmall extends StatefulWidget {
  const OnBoardingBodySmall({super.key});

  @override
  State<OnBoardingBodySmall> createState() => _OnBoardingBodySmallState();
}

class _OnBoardingBodySmallState extends State<OnBoardingBodySmall> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AppAssetsConfig.netflixBackground), context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const BackgroundImageCustom(),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Column(
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                final data = ref.watch(onBoardingDataProvider);
                return Flexible(
                  flex: 2,
                  child: PageView.builder(
                    controller: controller,
                    itemBuilder: (context, index) {
                      return OnBoardingItems(
                        model: data[index],
                      );
                    },
                    itemCount: data.length,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SmoothPageIndicatorCustom(controller: controller, count: 3),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ButtonCustom(
                title: const Text(
                  "Get Start",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColorsManager.white,
                  ),
                ),
                blurButton: 4,
                onClick: () {
                  context.go(Routes.welcome);
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ],
    );
  }
}
