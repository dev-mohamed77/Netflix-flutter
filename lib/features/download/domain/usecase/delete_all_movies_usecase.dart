import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/download/domain/repository/download_repository.dart';

class DeleteAllMoviesFromLocalStorageUseCase
    extends StateNotifier<AsyncValue<String?>> {
  final DownloadRepository repo;

  DeleteAllMoviesFromLocalStorageUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  Future<void> execute() async {
    state = const AsyncValue.loading();

    final result = await repo.deleteAllMoviesFromLocalStorage();

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
