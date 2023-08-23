import 'package:flutter/material.dart';
import 'package:netflix/core/components/movies_item.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/features/home/presentation/pages/widgets/home_title_see_all.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class TopMoviesSection extends StatelessWidget {
  const TopMoviesSection({super.key, required this.movies});

  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeTitleSeeAll(title: "Top 10 Movies This Week"),
        const VerticalSpacer(5),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.25,
          width: MediaQuery.sizeOf(context).width,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            padding: const EdgeInsets.only(left: 25, right: 10),
            itemBuilder: (context, index) {
              return MoviesItem(
                movie: movies[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 12,
              );
            },
          ),
        )
      ],
    );
  }
}
