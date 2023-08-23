import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/movie/domain/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/movie_entity.dart';

class DownloadMovieUseCase
    extends StateNotifier<AsyncValue<MovieDownloadModel?>> {
  final MovieRepository repo;
  DownloadMovieUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  final PublishSubject<int> downloadController = PublishSubject();

  Future<void> execute({
    required MovieEntity movie,
  }) async {
    state = const AsyncLoading();

    final result = await repo.downloadMovie(
      movie: movie,
      downloadController: downloadController,
    );

    state = result.when(success: (data) {
      return AsyncValue.data(data);
    }, failure: (errorHandle) {
      return AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      );
    });
  }
}
