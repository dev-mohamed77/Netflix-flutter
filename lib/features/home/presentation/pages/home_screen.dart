import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/error_custom.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/features/home/presentation/manager/providers.dart';
import 'package:netflix/features/home/presentation/pages/widgets/home_image_and_appbar.dart';
import 'package:netflix/features/home/presentation/pages/widgets/new_realeses_section.dart';
import 'package:netflix/features/home/presentation/pages/widgets/top_movies_image.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeData = ref.watch(getHomeUseCaseProvider);

    return homeData.when(
      data: (data) {
        return SingleChildScrollView(
          child: Column(
            children: [
              HomeImageAndAppBarSection(
                banner: data!.result.banners[0],
              ),
              const VerticalSpacer(15),
              TopMoviesSection(
                movies: data.result.topTenMovies,
              ),
              const VerticalSpacer(15),
              NewReleasesSection(
                movies: data.result.newReleaseMovies,
              ),
              const VerticalSpacer(30),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return ErrorCustom(
          title: error.toString(),
          onClick: () {
            ref.read(getHomeUseCaseProvider.notifier).execute();
          },
        );
      },
      loading: () => const LoadingPage(title: "Loading  ..."),
    );
  }
}
