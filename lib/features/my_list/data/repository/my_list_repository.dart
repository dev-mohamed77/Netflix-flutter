// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:netflix/features/my_list/data/data_source/my_list_remote_data_source.dart';
import 'package:netflix/features/my_list/domain/entities/add_or_delete_favorite_entity.dart';

import '../../domain/repository/my_list_repository.dart';

class MyListRepositoryImp implements MyListRepository {
  final MyListRemoteDataSource dataSource;

  MyListRepositoryImp({
    required this.dataSource,
  });
  @override
  Future<ApiResult<AddOrDeleteFavoriteEntity>> addFavorite({
    required String movieId,
  }) async {
    try {
      final res = await dataSource.addFavorite(movieId: movieId);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<AddOrDeleteFavoriteEntity>> deleteFavorite({
    required String movieId,
  }) async {
    try {
      final res = await dataSource.deleteFavorite(movieId: movieId);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<MovieEntity>>> getFavorites() async {
    try {
      final res = await dataSource.getFavorites();

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final myListRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(myListRemoteDataSourceProvider);
  return MyListRepositoryImp(dataSource: dataSource);
});
