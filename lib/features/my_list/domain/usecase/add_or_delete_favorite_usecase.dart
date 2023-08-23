import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/my_list/domain/entities/add_or_delete_favorite_entity.dart';
import 'package:netflix/features/my_list/presentation/manager/providers.dart';

import '../../../../core/api/api_error_handle.dart';
import '../repository/my_list_repository.dart';

class AddOrDeleteFavoriteUseCase
    extends StateNotifier<AsyncValue<AddOrDeleteFavoriteEntity?>> {
  AddOrDeleteFavoriteUseCase({required this.ref, required this.repo})
      : super(const AsyncValue.data(null));

  final MyListRepository repo;
  final Ref ref;

  Future<void> addFavorite({
    required String movieID,
  }) async {
    state = const AsyncLoading();
    final result = await repo.addFavorite(movieId: movieID);

    state = result.when(
      success: (data) {
        ref.read(getFavoritesUseCaseProvider.notifier).addFavorite(data.result);
        return AsyncValue.data(data);
      },
      failure: (errorHandle) => AsyncError(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }

  Future<void> deleteFavorite({
    required String movieID,
  }) async {
    state = const AsyncLoading();
    final result = await repo.deleteFavorite(movieId: movieID);

    state = result.when(
      success: (data) {
        ref
            .read(getFavoritesUseCaseProvider.notifier)
            .deleteFavorite(data.result);
        return AsyncValue.data(data);
      },
      failure: (errorHandle) => AsyncError(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
