import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/plans/domain/entity/plan_entity.dart';

import '../../../../core/api/api_result.dart';

abstract class PlanRepository {
  Future<ApiResult<List<PlanEntity>>> getPlans();
  Future<ApiResult<UserEntity>> onSubscribePlan(String planId);
  Future<ApiResult<UserEntity>> onUnSubscribePlan();
}
