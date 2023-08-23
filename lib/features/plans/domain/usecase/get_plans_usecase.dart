import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:netflix/features/plans/domain/entity/plan_entity.dart';
import 'package:netflix/features/plans/domain/repository/plan_repository.dart';

import '../../../../core/api/api_error_handle.dart';

class GetPlansUseCase extends StateNotifier<AsyncValue<List<PlanEntity>?>> {
  GetPlansUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null)) {
    execute();
  }

  final PlanRepository repo;

  Future<void> execute() async {
    state = const AsyncLoading();

    final result = await repo.getPlans();

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (err) => AsyncError(
        ErrorHandle.getErrorMessage(err),
        StackTrace.current,
      ),
    );
  }
}
