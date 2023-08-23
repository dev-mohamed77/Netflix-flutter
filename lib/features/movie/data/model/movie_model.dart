// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.streamUrl,
    required super.language,
    required super.cast,
    required super.directors,
    required super.releaseDate,
    required super.isFavorite,
    required super.runtime,
    required super.viewCount,
    required super.categories,
    required super.createdAt,
    required super.updatedAt,
  });

  MovieModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? streamUrl,
    List<String>? language,
    List<String>? cast,
    List<String>? directors,
    String? releaseDate,
    bool? isFavorite,
    String? runtime,
    int? viewCount,
    List<dynamic>? categories,
    String? createdAt,
    String? updatedAt,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      streamUrl: streamUrl ?? this.streamUrl,
      language: language ?? this.language,
      cast: cast ?? this.cast,
      directors: directors ?? this.directors,
      releaseDate: releaseDate ?? this.releaseDate,
      isFavorite: isFavorite ?? this.isFavorite,
      runtime: runtime ?? this.runtime,
      viewCount: viewCount ?? this.viewCount,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'streamUrl': streamUrl,
      'language': language,
      'cast': cast,
      'directors': directors,
      'releaseDate': releaseDate,
      'isFavorite': isFavorite,
      'runtime': runtime,
      'viewCount': viewCount,
      'categories': categories,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['_id'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
      streamUrl: map['streamUrl'] ?? "",
      language: List<String>.from((map['language'] ?? [])),
      cast: List<String>.from((map['cast'] ?? [])),
      directors: List<String>.from((map['directors'] ?? [])),
      releaseDate: map['releaseDate'] ?? "",
      isFavorite: map['isFavorite'] ?? false,
      runtime: map['runtime'] ?? "",
      viewCount: map['viewCount'] as int,
      categories: List<dynamic>.from((map['categories'] ?? [])),
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, streamUrl: $streamUrl, language: $language, cast: $cast, directors: $directors, releaseDate: $releaseDate, isFavorite: $isFavorite, runtime: $runtime, viewCount: $viewCount, categories: $categories, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant MovieModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.streamUrl == streamUrl &&
        listEquals(other.language, language) &&
        listEquals(other.cast, cast) &&
        listEquals(other.directors, directors) &&
        other.releaseDate == releaseDate &&
        other.isFavorite == isFavorite &&
        other.runtime == runtime &&
        other.viewCount == viewCount &&
        listEquals(other.categories, categories) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        streamUrl.hashCode ^
        language.hashCode ^
        cast.hashCode ^
        directors.hashCode ^
        isFavorite.hashCode ^
        releaseDate.hashCode ^
        runtime.hashCode ^
        viewCount.hashCode ^
        categories.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
