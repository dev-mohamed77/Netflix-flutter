import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/error_custom.dart';
import 'package:netflix/core/components/movie_loading_shimmer.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';
import 'package:netflix/features/my_list/presentation/manager/providers.dart';

import '../../../../../core/components/movies_item.dart';
import '../../../../../core/components/no_data.dart';

class MyListGridView extends ConsumerWidget {
  const MyListGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myList = ref.watch(getFavoritesUseCaseProvider);

    ref.listen(getFavoritesUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        error: (error, stackTrace) {
          DialogCustom.showSnackBar(context, message: error.toString());
        },
      );
    });

    return myList.when(
      loading: () => const MovieLoadingShimmer(),
      data: (data) {
        if (data!.isEmpty) {
          return const NoData(
            description:
                "it seems that you haven't added any movies to the list",
            title: 'Your List is Empty',
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1 / 1.4,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return MoviesItem(movie: data[index]);
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return ErrorCustom(
            title: error.toString(),
            onClick: () {
              ref.read(getFavoritesUseCaseProvider.notifier).execute();
            });
      },
    );
  }
}
