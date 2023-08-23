import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/movie/domain/repository/movie_repository.dart';
import 'package:netflix/features/movie/presentation/manager/providers.dart';

import '../entities/movie_entity.dart';

class GetMovieByIDUseCase extends StateNotifier<AsyncValue<MovieEntity?>> {
  final MovieRepository repo;
  final Ref ref;
  GetMovieByIDUseCase({
    required this.repo,
    required this.ref,
  }) : super(const AsyncValue.data(null));

  Future<void> execute({
    required String id,
  }) async {
    state = const AsyncLoading();

    final result = await repo.getMovieById(id: id);

    state = result.when(
      success: (data) {
        ref.read(addMovieToMyListProvider.notifier).getState(data.isFavorite);
        return AsyncValue.data(data);
      },
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
