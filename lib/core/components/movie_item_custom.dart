import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class MovieItemCustom extends StatelessWidget {
  const MovieItemCustom({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: context.height * 0.14,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: movie.imageUrl,
                  height: double.infinity,
                  width: context.width * 0.40,
                  fit: BoxFit.cover,
                ),
                const Icon(
                  Icons.play_circle,
                  color: AppColorsManager.white,
                  size: 35,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const VerticalSpacer(20),
                Text(
                  movie.runtime,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
