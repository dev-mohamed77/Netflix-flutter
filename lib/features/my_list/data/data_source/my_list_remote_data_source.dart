// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/movie/data/model/movie_model.dart';
import 'package:netflix/features/my_list/data/model/add_or_delete_favorite_model.dart';

abstract class MyListRemoteDataSource {
  Future<AddOrDeleteFavoriteModel> addFavorite({
    required String movieId,
  });
  Future<AddOrDeleteFavoriteModel> deleteFavorite({
    required String movieId,
  });
  Future<List<MovieModel>> getFavorites();
}

class MyListRemoteDataSourceImp implements MyListRemoteDataSource {
  final NetworkService networkService;

  MyListRemoteDataSourceImp({
    required this.networkService,
  });

  @override
  Future<AddOrDeleteFavoriteModel> addFavorite({
    required String movieId,
  }) async {
    final response = await networkService.postData(
      "favorite/",
      data: {
        "movie": movieId,
      },
    );

    final data = response.data;

    return AddOrDeleteFavoriteModel.fromMap(data);
  }

  @override
  Future<AddOrDeleteFavoriteModel> deleteFavorite({
    required String movieId,
  }) async {
    final response = await networkService.deleteData(
      "favorite/",
      data: {
        "movie": movieId,
      },
    );

    final data = response.data;

    return AddOrDeleteFavoriteModel.fromMap(data);
  }

  @override
  Future<List<MovieModel>> getFavorites() async {
    final response = await networkService.getData("favorite");

    final Iterable data = response.data["result"]["data"];

    final favorites = data.map((e) => MovieModel.fromMap(e["movie"])).toList();

    return favorites;
  }
}

final myListRemoteDataSourceProvider = Provider((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return MyListRemoteDataSourceImp(networkService: networkService);
});
