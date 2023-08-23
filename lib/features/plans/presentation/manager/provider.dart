import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/plans/domain/entity/plan_entity.dart';
import 'package:netflix/features/plans/domain/usecase/get_plans_usecase.dart';
import 'package:netflix/features/plans/domain/usecase/onsubscribe_usecase.dart';
import 'package:netflix/features/plans/domain/usecase/onunsubscribe_usecase.dart';

import '../../data/repository/plan_repository_imp.dart';

final getPlansUseCaseProvider =
    StateNotifierProvider<GetPlansUseCase, AsyncValue<List<PlanEntity>?>>(
        (ref) {
  final repo = ref.watch(planRepositoryProvider);

  return GetPlansUseCase(repo: repo);
});

final onUnSubscribeUseCaseProvider =
    StateNotifierProvider<OnUnSubscribeUseCase, AsyncValue<UserEntity?>>((ref) {
  final repo = ref.watch(planRepositoryProvider);

  return OnUnSubscribeUseCase(repo: repo, ref: ref);
});

final onSubscribeUseCaseProvider =
    StateNotifierProvider<OnSubscribeUseCase, AsyncValue<UserEntity?>>((ref) {
  final repo = ref.watch(planRepositoryProvider);

  return OnSubscribeUseCase(repo: repo, ref: ref);
});
