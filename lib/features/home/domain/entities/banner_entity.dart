// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class BannerEntity extends Equatable {
  final String id;
  final String image;
  final MovieEntity movie;
  final String createdAt;
  final String updatedAt;

  const BannerEntity({
    required this.id,
    required this.image,
    required this.movie,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      image,
      movie,
      createdAt,
      updatedAt,
    ];
  }
}
