import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/components/error_custom.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';
import 'package:netflix/features/movie/presentation/pages/widgets/buttons_movie_sction.dart';
import 'package:netflix/features/movie/presentation/pages/widgets/categories_movie_section.dart';
import 'package:netflix/features/movie/presentation/pages/widgets/title_movie_section.dart';

import '../../../../my_list/presentation/manager/providers.dart';
import '../../manager/providers.dart';
import 'background_image_section.dart';
import 'movies_suggestion.dart';

class MovieBody extends ConsumerWidget {
  const MovieBody({super.key, required this.image, required this.movieID});

  final String image;
  final String movieID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(getMovieByIDProvider);

    ref.listen(addOrDeleteFavoriteUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: data?.message ?? "",
            color: AppColorsManager.green,
          );
        },
        error: (error, stackTrace) {
          ref.read(addMovieToMyListProvider.notifier).getState(false);
          DialogCustom.showSnackBar(context, message: error.toString());
        },
      );
    });

    ref.listen(downloadMovieProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: "download movie successfully",
            color: AppColorsManager.green,
          );
        },
        error: (error, stackTrace) {
          ref.read(addMovieToMyListProvider.notifier).getState(false);
          DialogCustom.showSnackBar(context, message: error.toString());
        },
      );
    });

    return movie.when(
      loading: () => const LoadingPage(title: "Loading ..."),
      data: (data) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackgroundImageSection(
                image: image,
              ),
              const VerticalSpacer(10),
              TitleMovieSection(movie: data!),
              const VerticalSpacer(15),
              CategoriesMovieSection(
                categories: data.categories,
              ),
              const VerticalSpacer(15),
              ButtonsMovieSection(movie: data),
              const VerticalSpacer(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  data.description,
                  style: const TextStyle(height: 2, fontSize: 14.5),
                ),
              ),
              const MoviesSuggestion()
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return ErrorCustom(
          title: error.toString(),
          onClick: () {
            ref.read(getMovieByIDProvider.notifier).execute(id: movieID);
          },
        );
      },
    );
  }
}
