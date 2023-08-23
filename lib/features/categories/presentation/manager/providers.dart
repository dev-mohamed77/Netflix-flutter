import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/categories/data/repository/categories_repository.dart';
import 'package:netflix/features/categories/domain/entities/category_entity.dart';
import 'package:netflix/features/categories/domain/usecase/get_categories_usecase.dart';

final getCategoriesUseCaseProvider = StateNotifierProvider<GetCategoriesUseCase,
    AsyncValue<List<CategoryEntity>?>>((ref) {
  final repo = ref.watch(categoriesRepositoryProvider);
  return GetCategoriesUseCase(repo: repo);
});
