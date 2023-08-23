// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/categories/data/model/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryModel> createCategory();
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> getCategoryByID();
  Future<CategoryModel> updateCategory();
  Future<CategoryModel> deleteCategory();
}

class CategoriesRemoteDataSourceImp implements CategoriesRemoteDataSource {
  final NetworkService networkService;

  CategoriesRemoteDataSourceImp({
    required this.networkService,
  });
  @override
  Future<CategoryModel> createCategory() {
    // TODO: implement createCategory
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> deleteCategory() {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await networkService.getData("categories");

    final Iterable data = response.data["result"];

    final categories = data.map((e) => CategoryModel.fromMap(e)).toList();

    return categories;
  }

  @override
  Future<CategoryModel> getCategoryByID() {
    // TODO: implement getCategoryByID
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> updateCategory() {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}

final categoriesRemoteDataSourceProvider = Provider((ref) {
  final network = ref.watch(networkServiceProvider);
  return CategoriesRemoteDataSourceImp(networkService: network);
});
