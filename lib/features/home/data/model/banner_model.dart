// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:netflix/features/home/domain/entities/banner_entity.dart';
import 'package:netflix/features/movie/data/model/movie_model.dart';

class BannerModel extends BannerEntity {
  final MovieModel movie;
  const BannerModel({
    required super.id,
    required super.image,
    required this.movie,
    required super.createdAt,
    required super.updatedAt,
  }) : super(movie: movie);

  BannerModel copyWith({
    String? id,
    String? image,
    MovieModel? movie,
    String? createdAt,
    String? updatedAt,
  }) {
    return BannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      movie: movie ?? this.movie,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'movie': movie.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] ?? "",
      image: map['image'] ?? "",
      movie: MovieModel.fromMap(map['movie']),
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BannerModel(id: $id, image: $image, movie: $movie, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        other.movie == movie &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        movie.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
