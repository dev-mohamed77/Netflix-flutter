// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String streamUrl;
  final List<String> language;
  final List<String> cast;
  final List<String> directors;
  final String releaseDate;
  final bool isFavorite;
  final String runtime;
  final int viewCount;
  final List<dynamic> categories;
  final String createdAt;
  final String updatedAt;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.streamUrl,
    required this.language,
    required this.cast,
    required this.directors,
    required this.releaseDate,
    required this.isFavorite,
    required this.runtime,
    required this.viewCount,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      imageUrl,
      streamUrl,
      language,
      cast,
      directors,
      releaseDate,
      isFavorite,
      runtime,
      viewCount,
      categories,
      createdAt,
      updatedAt,
    ];
  }
}
