// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/categories/data/data_source/categories_data_source.dart';
import 'package:netflix/features/categories/domain/entities/category_entity.dart';
import 'package:netflix/features/categories/domain/repository/category_repository.dart';

class CategoriesRepositoryImp implements CategoriesRepository {
  final CategoriesRemoteDataSource dataSource;

  CategoriesRepositoryImp({
    required this.dataSource,
  });

  @override
  Future<ApiResult<CategoryEntity>> createCategory() {
    // TODO: implement createCategory
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<CategoryEntity>> deleteCategory() {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    try {
      final res = await dataSource.getCategories();

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<CategoryEntity>> getCategoryByID() {
    // TODO: implement getCategoryByID
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<CategoryEntity>> updateCategory() {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}

final categoriesRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(categoriesRemoteDataSourceProvider);
  return CategoriesRepositoryImp(dataSource: dataSource);
});
