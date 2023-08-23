import 'package:flutter/material.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

import 'widgets/movie_body.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({
    super.key,
    required this.image,
    required this.movieID,
  });

  final String image;
  final String movieID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColorsManager.transparent,
        foregroundColor: AppColorsManager.white,
        elevation: 0,
      ),
      body: MovieBody(
        image: image,
        movieID: movieID,
      ),
    );
  }
}
