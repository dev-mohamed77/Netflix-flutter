import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/providers/user_local_provider.dart';

import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/plans/domain/repository/plan_repository.dart';

import '../../../../core/api/api_error_handle.dart';

class OnSubscribeUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  OnSubscribeUseCase({required this.repo, required this.ref})
      : super(const AsyncValue.data(null));

  final PlanRepository repo;
  final Ref ref;

  Future<void> execute({required String planId}) async {
    state = const AsyncLoading();

    final result = await repo.onSubscribePlan(planId);

    result.when(
      success: (data) {
        state = AsyncValue.data(data);
        ref.watch(userLocalProvider.notifier).setUser(data);
      },
      failure: (err) => state = AsyncError(
        ErrorHandle.getErrorMessage(err),
        StackTrace.current,
      ),
    );
  }
}
