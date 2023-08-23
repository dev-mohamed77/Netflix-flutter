// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/download/domain/repository/download_repository.dart';

class DeleteMovieFromLocalStorageUseCase
    extends StateNotifier<AsyncValue<List<FileSystemEntity>?>> {
  final DownloadRepository repo;
  DeleteMovieFromLocalStorageUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  Future<void> execute({
    required String pathStream,
    required String pathImage,
  }) async {
    state = const AsyncValue.loading();

    final result = await repo.deleteMovieFromLocalStorage(
      pathStream: pathStream,
      pathImage: pathImage,
    );

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
