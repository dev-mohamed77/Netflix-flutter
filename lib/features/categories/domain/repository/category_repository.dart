import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/categories/domain/entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<ApiResult<CategoryEntity>> createCategory();
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  Future<ApiResult<CategoryEntity>> getCategoryByID();
  Future<ApiResult<CategoryEntity>> updateCategory();
  Future<ApiResult<CategoryEntity>> deleteCategory();
}
