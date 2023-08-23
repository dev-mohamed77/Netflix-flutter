import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:rxdart/rxdart.dart';

abstract class MovieRepository {
  Future<ApiResult<MovieEntity>> getMovieById({
    required String id,
  });

  Future<ApiResult<MovieDownloadModel>> downloadMovie({
    required MovieEntity movie,
    required PublishSubject<int> downloadController,
  });
}
