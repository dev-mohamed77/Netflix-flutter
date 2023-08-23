import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

import '../../features/movie/presentation/manager/providers.dart';

class MoviesItem extends ConsumerWidget {
  const MoviesItem({super.key, required this.movie});
  final MovieEntity movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(getMovieByIDProvider.notifier).execute(id: movie.id);
        context.pushNamed(
          Routes.movie,
          extra: movie.imageUrl,
          queryParameters: {"id": movie.id},
        );
      },
      child: Container(
        height: double.infinity,
        width: context.width / 2.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              movie.imageUrl,
              errorListener: () => const Icon(Icons.error),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 25,
              margin: const EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: context.accentColor,
              ),
              child: const Text(
                "9.5",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColorsManager.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
