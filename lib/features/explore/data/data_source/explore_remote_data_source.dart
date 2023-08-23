// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/movie/data/model/movie_model.dart';

abstract class ExploreRemoteDataSource {
  Future<List<MovieModel>> getMovies({
    String? search,
    int? limit,
    int? page,
  });
  Future<List<MovieModel>> getMoviesByCategoryID({
    required List<String> categoriesID,
    int? limit,
    int? page,
  });
}

class ExploreRemoteDataSourceImp extends ExploreRemoteDataSource {
  final NetworkService networkService;

  ExploreRemoteDataSourceImp({
    required this.networkService,
  });

  @override
  Future<List<MovieModel>> getMovies({
    String? search,
    int? limit,
    int? page,
  }) async {
    final res = await networkService.getData("movies", queryParams: {
      "limit": limit,
      "page": page,
      "search": search,
    });

    final Iterable data = res.data["result"]["data"];

    final List<MovieModel> movies =
        data.map((e) => MovieModel.fromMap(e)).toList();

    return movies;
  }

  @override
  Future<List<MovieModel>> getMoviesByCategoryID({
    required List<String> categoriesID,
    int? limit,
    int? page,
  }) async {
    final res = await networkService.getData("movies/categories", queryParams: {
      "limit": limit,
      "page": page,
    }, data: {
      "categories": categoriesID
    });

    final Iterable data = res.data["result"]["data"];

    final List<MovieModel> movies =
        data.map((e) => MovieModel.fromMap(e)).toList();

    return movies;
  }
}

final exploreRemoteDataSourceProvider = Provider((ref) {
  final network = ref.watch(networkServiceProvider);

  return ExploreRemoteDataSourceImp(networkService: network);
});
