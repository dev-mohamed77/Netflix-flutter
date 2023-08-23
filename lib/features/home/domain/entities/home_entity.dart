// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:netflix/features/home/domain/entities/banner_entity.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class HomeEntity extends Equatable {
  final bool status;
  final HomeResult result;

  const HomeEntity({
    required this.status,
    required this.result,
  });

  @override
  List<Object> get props => [
        status,
      ];
}

class HomeResult extends Equatable {
  final List<BannerEntity> banners;
  final List<MovieEntity> topTenMovies;
  final List<MovieEntity> newReleaseMovies;

  const HomeResult({
    required this.banners,
    required this.topTenMovies,
    required this.newReleaseMovies,
  });

  @override
  List<Object> get props => [banners, topTenMovies, newReleaseMovies];
}
