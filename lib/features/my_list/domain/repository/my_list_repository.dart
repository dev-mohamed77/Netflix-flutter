import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:netflix/features/my_list/domain/entities/add_or_delete_favorite_entity.dart';

abstract class MyListRepository {
  Future<ApiResult<AddOrDeleteFavoriteEntity>> addFavorite({
    required String movieId,
  });

  Future<ApiResult<AddOrDeleteFavoriteEntity>> deleteFavorite({
    required String movieId,
  });

  Future<ApiResult<List<MovieEntity>>> getFavorites();
}
