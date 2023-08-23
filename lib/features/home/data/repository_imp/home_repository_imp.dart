// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/home/data/data_source/home_remote_data_source.dart';
import 'package:netflix/features/home/domain/entities/home_entity.dart';
import 'package:netflix/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp({
    required this.homeRemoteDataSource,
  });

  @override
  Future<ApiResult<HomeEntity>> home() async {
    try {
      final response = await homeRemoteDataSource.getHome();
      return ApiResult.success(response);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final homeRepositoryProvider = Provider((ref) {
  final homeDataSource = ref.watch(homeRemoteDataSourceProvider);

  return HomeRepositoryImp(homeRemoteDataSource: homeDataSource);
});
