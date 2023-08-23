import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/movie/data/repository/movie_repository_imp.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:netflix/features/movie/domain/usecase/download_movie_usecase.dart';
import 'package:netflix/features/movie/domain/usecase/get_movie_by_id_usecase.dart';

import 'add_movie_to_my_list.dart';

final getMovieByIDProvider =
    StateNotifierProvider<GetMovieByIDUseCase, AsyncValue<MovieEntity?>>((ref) {
  final repo = ref.watch(movieRepositoryProvider);
  return GetMovieByIDUseCase(repo: repo, ref: ref);
});

final addMovieToMyListProvider =
    StateNotifierProvider<AddMovieToMyList, bool?>((ref) {
  return AddMovieToMyList();
});

final downloadMovieProvider = StateNotifierProvider<DownloadMovieUseCase,
    AsyncValue<MovieDownloadModel?>>((ref) {
  final repo = ref.watch(movieRepositoryProvider);
  return DownloadMovieUseCase(repo: repo);
});
