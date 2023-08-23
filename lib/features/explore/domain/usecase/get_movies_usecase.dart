// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/explore/domain/repository/explore_repository.dart';
import 'package:netflix/features/explore/presentation/manager/categories_select_providers.dart';
import 'package:netflix/features/explore/presentation/manager/page_controller_provider.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class GetMoviesUseCase extends StateNotifier<AsyncValue<List<MovieEntity>?>> {
  final ExploreRepository repo;
  final Ref ref;
  GetMoviesUseCase({
    required this.repo,
    required this.ref,
  }) : super(const AsyncValue.data(null)) {
    final categoriesId = ref.watch(selectedCategoriesProvider);
    if (categoriesId.isEmpty) {
      getMovies();
    } else {
      getMoviesByCategoriesId(categoriesId);
    }

    ref.watch(pageControllerProvider).addListener(() {
      _loadedMoreData();
    });
  }

  int page = 1;
  int limit = 5;
  bool noMoreItem = false;

  Future<void> getMovies() async {
    state = const AsyncValue.loading();

    page = 1;

    final result = await repo.getMovies(
      page: page,
      limit: limit,
    );

    if (mounted) {
      state = result.when(
        success: (data) {
          noMoreItem = data.length < limit;
          return AsyncValue.data(data);
        },
        failure: (errorHandle) => AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.current,
        ),
      );
    }
  }

  Future<void> getSearchMovies({
    String? search,
  }) async {
    state = const AsyncValue.loading();
    final result = await repo.getMovies(
      page: page,
      limit: limit,
      search: search,
    );

    state = result.when(
      success: (data) {
        noMoreItem = data.length < limit;
        return AsyncValue.data(data);
      },
      failure: (errorHandle) => AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }

  // ----------------  Get Movies By Categories ID ------------------

  Future<void> getMoviesByCategoriesId(List<String> categoriesId) async {
    state = const AsyncValue.loading();

    page = 1;

    final result = await repo.getMoviesByCategoryID(
      categoriesID: categoriesId,
      page: page,
      limit: limit,
    );

    if (mounted) {
      state = result.when(
        success: (data) {
          noMoreItem = data.length < limit;
          return AsyncValue.data(data);
        },
        failure: (errorHandle) => AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.current,
        ),
      );
    }
  }

  Future<void> _loadedMoreData() async {
    if (_isMaxScroll()) {
      if (!noMoreItem) {
        page++;
      }

      if (!noMoreItem) {
        final categoriesId = ref.watch(selectedCategoriesProvider);

        if (categoriesId.isEmpty) {
          _getMoviesResult();
        } else {
          _getMoviesByCategoryIdResult(categoriesId);
        }
      }
    }
  }

  _getMoviesResult() async {
    final result = await repo.getMovies(
      page: page,
      limit: limit,
    );

    if (mounted) {
      state = result.when(
        success: (data) {
          noMoreItem = data.length < limit;
          return AsyncValue.data([...state.value ?? [], ...data]);
        },
        failure: (errorHandle) => AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.current,
        ),
      );
    }
  }

  _getMoviesByCategoryIdResult(List<String> categoriesId) async {
    final result = await repo.getMoviesByCategoryID(
      categoriesID: categoriesId,
      page: page,
      limit: limit,
    );

    if (mounted) {
      state = result.when(
        success: (data) {
          noMoreItem = data.length < limit;
          return AsyncValue.data([...state.value ?? [], ...data]);
        },
        failure: (errorHandle) => AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.current,
        ),
      );
    }
  }

  bool _isMaxScroll() {
    return ref.watch(pageControllerProvider).position.pixels ==
        ref.watch(pageControllerProvider).position.maxScrollExtent;
  }
}
