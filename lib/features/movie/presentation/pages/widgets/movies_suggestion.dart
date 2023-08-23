import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/features/explore/presentation/manager/providers.dart';

import '../../../../../core/components/movie_item_custom.dart';
import '../../../../../core/components/vertical_spacer.dart';

class MoviesSuggestion extends ConsumerWidget {
  const MoviesSuggestion({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(getMoviesUseCaseProvider);

    return movies.when(
      data: (data) {
        return SizedBox(
          width: context.width,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return MovieItemCustom(movie: data![index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const VerticalSpacer(15);
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () => const LoadingPage(title: 'Loading ...'),
    );
  }
}
