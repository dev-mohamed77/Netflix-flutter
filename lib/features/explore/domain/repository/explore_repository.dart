import 'package:netflix/core/api/api_result.dart';

import '../../../movie/domain/entities/movie_entity.dart';

abstract class ExploreRepository {
  Future<ApiResult<List<MovieEntity>>> getMovies({
    String? search,
    int? page,
    int? limit,
  });
  Future<ApiResult<List<MovieEntity>>> getMoviesByCategoryID({
    required List<String> categoriesID,
    int? page,
    int? limit,
  });
}
