import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/download/data/repository/download_repository.dart';
import 'package:netflix/features/download/domain/usecase/delete_all_movies_usecase.dart';
import 'package:netflix/features/download/domain/usecase/delete_movie_usecase.dart';

final deleteMovieFromLocalStorageUseCaseProvider = StateNotifierProvider<
    DeleteMovieFromLocalStorageUseCase,
    AsyncValue<List<FileSystemEntity>?>>((ref) {
  final repo = ref.watch(downloadRepositoryProvider);

  return DeleteMovieFromLocalStorageUseCase(repo: repo);
});

final deleteAllMoviesFromLocalStorageUseCaseProvider = StateNotifierProvider<
    DeleteAllMoviesFromLocalStorageUseCase, AsyncValue<String?>>((ref) {
  final repo = ref.watch(downloadRepositoryProvider);

  return DeleteAllMoviesFromLocalStorageUseCase(repo: repo);
});
