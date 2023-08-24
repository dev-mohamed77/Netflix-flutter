import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/elevated_button_icon_custom.dart';
import 'package:netflix/core/components/outline_button_icon_custom.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/home/domain/entities/banner_entity.dart';
import 'package:netflix/features/movie/presentation/manager/providers.dart';

import '../../../../../core/components/vertical_spacer.dart';
import '../../../../../core/config/app_assets_config.dart';
import '../../../../../core/manager/color/colors_manager.dart';
import '../../../../nav_bar/presentation/manager/navigation_bar_notifier.dart';

class HomeImageAndAppBarSection extends StatelessWidget {
  const HomeImageAndAppBarSection({super.key, required this.banner});

  final BannerEntity banner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height / 2.1,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(banner.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacer(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                AppAssetsConfig.netflixLogo,
                width: 20,
              ),
              Row(
                children: [
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, _) {
                      return IconButton(
                        onPressed: () {
                          context.push(Routes.explore);
                          ref.read(navigationBarProvider.notifier).select(1);
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                          color: AppColorsManager.white,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 30,
                      color: AppColorsManager.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            banner.movie.title,
            style: const TextStyle(
              color: AppColorsManager.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalSpacer(3),
          const Text(
            "Actions, Superhero, Science",
            style: TextStyle(
              color: AppColorsManager.white,
              fontSize: 13,
            ),
          ),
          Row(
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, _) {
                  return ElevatedButtonIconCustom(
                    title: "Play",
                    icon: Icons.play_circle_outlined,
                    onClick: () {
                      ref
                          .read(getMovieByIDProvider.notifier)
                          .execute(id: banner.movie.id);
                      ref.context.push(Routes.movie, extra: banner.image);
                    },
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, _) {
                  return OutLineButtonIconCustom(
                    icon: Icons.add,
                    onClick: () {
                      context.push(Routes.myList);
                      ref.read(navigationBarProvider.notifier).select(2);
                    },
                    title: 'My List',
                  );
                },
              )
            ],
          ),
          const VerticalSpacer(30),
        ],
      ),
    );
  }
}
