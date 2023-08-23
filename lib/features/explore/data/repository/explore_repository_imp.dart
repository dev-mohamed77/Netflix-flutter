// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/explore/data/data_source/explore_remote_data_source.dart';
import 'package:netflix/features/explore/domain/repository/explore_repository.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class ExploreRepositoryImp implements ExploreRepository {
  final ExploreRemoteDataSource exploreRemoteDataSource;
  ExploreRepositoryImp({
    required this.exploreRemoteDataSource,
  });

  @override
  Future<ApiResult<List<MovieEntity>>> getMovies({
    String? search,
    int? page,
    int? limit,
  }) async {
    try {
      final response = await exploreRemoteDataSource.getMovies(
        search: search,
        limit: limit,
        page: page,
      );

      return ApiResult.success(response);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<MovieEntity>>> getMoviesByCategoryID({
    required List<String> categoriesID,
    int? page,
    int? limit,
  }) async {
    try {
      final response = await exploreRemoteDataSource.getMoviesByCategoryID(
        categoriesID: categoriesID,
        limit: limit,
        page: page,
      );
      return ApiResult.success(response);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final exploreRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(exploreRemoteDataSourceProvider);

  return ExploreRepositoryImp(exploreRemoteDataSource: remoteDataSource);
});
