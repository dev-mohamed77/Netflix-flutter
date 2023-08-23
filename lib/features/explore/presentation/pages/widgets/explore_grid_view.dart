import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/error_custom.dart';
import 'package:netflix/core/components/movie_loading_shimmer.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/features/explore/presentation/manager/page_controller_provider.dart';
import 'package:netflix/features/explore/presentation/manager/providers.dart';

import '../../../../../core/components/movies_item.dart';

class ExploreGridView extends ConsumerStatefulWidget {
  const ExploreGridView({super.key});

  @override
  ConsumerState<ExploreGridView> createState() => _ExploreGridViewState();
}

class _ExploreGridViewState extends ConsumerState<ExploreGridView> {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(getMoviesUseCaseProvider);

    return movies.when(
      data: (data) {
        return Expanded(
          child: GridView.builder(
            controller: ref.watch(pageControllerProvider),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1 / 1.4,
            ),
            itemCount: ref.read(getMoviesUseCaseProvider.notifier).noMoreItem
                ? data!.length
                : data!.length + 1,
            itemBuilder: (context, index) {
              if (index >= data.length) {
                return Center(
                  child: CircularProgressIndicator(
                    color: context.accentColor,
                  ),
                );
              }
              return MoviesItem(movie: data[index]);
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Expanded(
          child: ErrorCustom(
            title: error.toString(),
            onClick: () {
              ref.read(getMoviesUseCaseProvider.notifier).getMovies();
            },
          ),
        );
      },
      loading: () => const Expanded(
        child: MovieLoadingShimmer(),
      ),
    );
  }
}
