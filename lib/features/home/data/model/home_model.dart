// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:netflix/features/home/data/model/banner_model.dart';
import 'package:netflix/features/home/domain/entities/home_entity.dart';
import 'package:netflix/features/movie/data/model/movie_model.dart';

class HomeModel extends HomeEntity {
  final HomeResultModel result;

  const HomeModel({
    required super.status,
    required this.result,
  }) : super(result: result);

  HomeModel copyWith({
    bool? status,
    HomeResultModel? result,
  }) {
    return HomeModel(
      status: status ?? this.status,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'result': result.toMap(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      status: map['status'] as bool,
      result: HomeResultModel.fromMap(map['result'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HomeModel(status: $status, result: $result)';

  @override
  bool operator ==(covariant HomeModel other) {
    if (identical(this, other)) return true;

    return other.status == status && other.result == result;
  }

  @override
  int get hashCode => status.hashCode ^ result.hashCode;
}

class HomeResultModel extends HomeResult {
  final List<BannerModel> banners;
  final List<MovieModel> topTenMovies;
  final List<MovieModel> newReleaseMovies;

  const HomeResultModel({
    required this.banners,
    required this.topTenMovies,
    required this.newReleaseMovies,
  }) : super(
            banners: banners,
            topTenMovies: topTenMovies,
            newReleaseMovies: newReleaseMovies);

  HomeResultModel copyWith({
    List<BannerModel>? banners,
    List<MovieModel>? topTenMovies,
    List<MovieModel>? newReleaseMovies,
  }) {
    return HomeResultModel(
      banners: banners ?? this.banners,
      topTenMovies: topTenMovies ?? this.topTenMovies,
      newReleaseMovies: newReleaseMovies ?? this.newReleaseMovies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'banners': banners.map((x) => x.toMap()).toList(),
      'topTenMovies': topTenMovies.map((x) => x.toMap()).toList(),
      'newReleaseMovies': newReleaseMovies.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeResultModel.fromMap(Map<String, dynamic> map) {
    return HomeResultModel(
      banners: List<BannerModel>.from(
        (map['banners'] as List<dynamic>).map<BannerModel>(
          (x) => BannerModel.fromMap(x),
        ),
      ),
      topTenMovies: List<MovieModel>.from(
        (map['topTenMovies'] as List<dynamic>).map<MovieModel>(
          (x) => MovieModel.fromMap(x),
        ),
      ),
      newReleaseMovies: List<MovieModel>.from(
        (map['newReleaseMovies'] as List<dynamic>).map<MovieModel>(
          (x) => MovieModel.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeResultModel.fromJson(String source) =>
      HomeResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HomeResultModel(banners: $banners, topTenMovies: $topTenMovies, newReleaseMovies: $newReleaseMovies)';

  @override
  bool operator ==(covariant HomeResultModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.banners, banners) &&
        listEquals(other.topTenMovies, topTenMovies) &&
        listEquals(other.newReleaseMovies, newReleaseMovies);
  }

  @override
  int get hashCode =>
      banners.hashCode ^ topTenMovies.hashCode ^ newReleaseMovies.hashCode;
}
