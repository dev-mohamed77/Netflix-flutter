import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/plans/data/data_source/plan_remote_data_source.dart';
import 'package:netflix/features/plans/domain/entity/plan_entity.dart';
import 'package:netflix/features/plans/domain/repository/plan_repository.dart';

import '../../../../core/api/api_error_handle.dart';

class PlanRepositoryImp implements PlanRepository {
  PlanRepositoryImp({required this.planDataSource});

  final PlanDataSource planDataSource;

  @override
  Future<ApiResult<UserEntity>> onSubscribePlan(String planId) async {
    try {
      final res = await planDataSource.onSubscribePlan(planId);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<UserEntity>> onUnSubscribePlan() async {
    try {
      final res = await planDataSource.onUnSubscribePlan();

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<List<PlanEntity>>> getPlans() async {
    try {
      final res = await planDataSource.getPlans();
      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final planRepositoryProvider = Provider((ref) {
  final planRemoteDataSource = ref.watch(planRemoteDataSourceProvider);

  return PlanRepositoryImp(planDataSource: planRemoteDataSource);
});
