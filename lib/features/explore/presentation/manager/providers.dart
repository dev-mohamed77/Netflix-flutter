import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/explore/domain/usecase/get_movies_usecase.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

import '../../data/repository/explore_repository_imp.dart';

final getMoviesUseCaseProvider =
    StateNotifierProvider<GetMoviesUseCase, AsyncValue<List<MovieEntity>?>>(
  (ref) {
    final repo = ref.watch(exploreRepositoryProvider);

    return GetMoviesUseCase(repo: repo, ref: ref);
  },
);
