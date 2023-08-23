import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:netflix/features/my_list/domain/repository/my_list_repository.dart';

class GetFavoritesUseCase
    extends StateNotifier<AsyncValue<List<MovieEntity>?>> {
  GetFavoritesUseCase({required this.repo})
      : super(const AsyncValue.data(null)) {
    execute();
  }

  final MyListRepository repo;

  Future<void> execute() async {
    state = const AsyncLoading();
    final result = await repo.getFavorites();

    state = result.when(
      success: (data) {
        return AsyncValue.data(data);
      },
      failure: (errorHandle) => AsyncError(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }

  deleteFavorite(MovieEntity movie) {
    final items = state.value ?? [];

    state = const AsyncLoading();

    items.removeWhere((element) => element.id == movie.id);

    state = AsyncValue.data(items);
  }

  addFavorite(MovieEntity movie) {
    final items = state.value ?? [];

    state = const AsyncLoading();

    items.add(movie);

    state = AsyncValue.data(items);
  }
}
