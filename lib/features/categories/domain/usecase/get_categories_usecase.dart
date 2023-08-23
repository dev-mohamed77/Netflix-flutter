import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/categories/domain/entities/category_entity.dart';
import 'package:netflix/features/categories/domain/repository/category_repository.dart';

class GetCategoriesUseCase
    extends StateNotifier<AsyncValue<List<CategoryEntity>?>> {
  final CategoriesRepository repo;
  GetCategoriesUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null)) {
    execute();
  }

  Future<void> execute() async {
    state = const AsyncLoading();

    final result = await repo.getCategories();

    if (mounted) {
      state = result.when(
        success: (data) {
          return AsyncValue.data(data);
        },
        failure: (errorHandle) => AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.empty,
        ),
      );
    }
  }
}
