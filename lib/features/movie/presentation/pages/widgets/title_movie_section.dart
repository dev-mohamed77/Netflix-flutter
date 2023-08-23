import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:netflix/features/movie/presentation/manager/providers.dart';
import 'package:netflix/features/my_list/presentation/manager/providers.dart';

class TitleMovieSection extends StatelessWidget {
  const TitleMovieSection({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            movie.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, _) {
                  final isFavorite = ref.watch(addMovieToMyListProvider);
                  return IconButton(
                    onPressed: () {
                      ref
                          .read(addMovieToMyListProvider.notifier)
                          .select(isFavorite);

                      if (isFavorite) {
                        ref
                            .read(addOrDeleteFavoriteUseCaseProvider.notifier)
                            .deleteFavorite(movieID: movie.id);
                      } else {
                        ref
                            .read(addOrDeleteFavoriteUseCaseProvider.notifier)
                            .addFavorite(movieID: movie.id);
                      }
                    },
                    icon: isFavorite!
                        ? const Icon(Icons.bookmark_rounded)
                        : const Icon(Icons.bookmark_border),
                  );
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.share),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
