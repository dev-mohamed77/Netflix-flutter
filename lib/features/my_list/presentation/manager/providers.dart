import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:netflix/features/my_list/data/repository/my_list_repository.dart';

import '../../domain/entities/add_or_delete_favorite_entity.dart';
import '../../domain/usecase/add_or_delete_favorite_usecase.dart';
import '../../domain/usecase/get_favorites_usecase.dart';

final addOrDeleteFavoriteUseCaseProvider = StateNotifierProvider<
    AddOrDeleteFavoriteUseCase, AsyncValue<AddOrDeleteFavoriteEntity?>>((ref) {
  final repo = ref.watch(myListRepositoryProvider);
  return AddOrDeleteFavoriteUseCase(repo: repo, ref: ref);
});

final getFavoritesUseCaseProvider =
    StateNotifierProvider<GetFavoritesUseCase, AsyncValue<List<MovieEntity>?>>(
        (ref) {
  final repo = ref.watch(myListRepositoryProvider);
  return GetFavoritesUseCase(repo: repo);
});
